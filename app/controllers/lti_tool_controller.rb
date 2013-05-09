class LtiToolController < ApplicationController

    def lti_tool

        reset_session

        @tp = Consumer.authorize!(params, request)

        if @tp.lti_msg == 'success'

            session['launch_params'] = @tp.to_params
            session['lti_username'] = @tp.username
            session['current_context'] = @tp.context_label

            @consumer = Consumer.find_by_key(params['oauth_consumer_key'])

            @context = Consumer.set_up_context(@consumer, @tp)
            
            user = create_or_sign_in(@tp.lis_person_contact_email_primary) if @tp.lis_person_contact_email_primary

            if user && @tp.roles
                Consumer.set_membership(@tp, user, @context)
            end
            
            if @tp.custom_params['path']
                redirect_to "/#{@tp.custom_params['path']}"
            else
                if user
                    redirect_to @context, :notice => "Successful LTI launch from #{@tp.context_label}: #{@tp.context_title}"
                else
                    redirect_to :root, :notice => "No valid user data"
                end
            end
        else
            redirect_to :root, :alert => @tp.lti_msg
        end

    end

    def lti_exam
        @context = Context.find(params[:context]);

        if session['launch_params']
            key = session['launch_params']['oauth_consumer_key']
        else
            flash[:alert] = "Tool never launched."
        end

        @tp = IMS::LTI::ToolProvider.new(key, Consumer.find_by_key(key).secret, session['launch_params'])

        if !@tp.outcome_service?
            redirect_to @context, :alert =>  "Tool not launched as an outcome service."
        else
            res = @tp.post_replace_result!(params['score'])

            if res.success?
                redirect_to @context, :notice => "You gave yourself #{params['score'].to_f * 100}"
            else
                flash[:alert] = "Score not sent. #{res.description}"
            end
        end

    end

    def create_or_sign_in(email)
        if user = User.find_by_email(email)
        else
            user = User.create!( :email => email, :password => Devise.friendly_token[0,20])
        end
        sign_in :user, user
    end

end
