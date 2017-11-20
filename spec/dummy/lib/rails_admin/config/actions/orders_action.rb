module RailsAdmin
  module Config
    module Actions
      class OrdersActions < RailsAdmin::Config::Actions::Base
        register_instance_option :member do
          true
        end
        register_instance_option :only do
          Order
        end
        register_instance_option :visible? do
          authorized?
        end
      end
      class ChangeState < OrdersActions
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :visible? do
          if bindings[:object].class.name == 'Order'
            !bindings[:object].cancelled? && !bindings[:object].delivered?
          end
        end
        register_instance_option :link_icon do
          'fa fa-exchange'
        end
        register_instance_option :controller do
          proc do
            if request.get?
              @events = []
              object.aasm.events.map(&:name).each do |event|
                @events << event if object.public_send("may_#{event}?")
              end
            elsif request.post?
              if params[:state] && params[:state][:event] && object.public_send("#{params[:state][:event]}!")
                flash[:notice] = I18n.t('admin.actions.change_state.flash.success')
              else
                flash[:error] = I18n.t('admin.actions.change_state.flash.error')
              end
              redirect_to back_or_index
            end
          end
        end
        register_instance_option :http_methods do
          %i[get post]
        end
      end
    end
  end
end
