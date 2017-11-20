module RailsAdmin
  module Config
    module Actions
      class OrdersTabs < RailsAdmin::Config::Actions::Base
        register_instance_option :collection do
          true
        end
        register_instance_option :only do
          Order
        end
        register_instance_option :visible? do
          authorized?
        end
        register_instance_option :http_methods do
          [:get]
        end
      end

      class InProgressTab < OrdersTabs
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :link_icon do
          'fa fa-spinner'
        end
        register_instance_option :controller do
          proc do
            @objects = Order.where(aasm_state: %w[in_progress waiting_for_processing in_delivery pending])
            render :index
          end
        end
      end

      class DeliveredTab < OrdersTabs
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :link_icon do
          'fa fa-paper-plane'
        end
        register_instance_option :controller do
          proc do
            @objects = Order.where(aasm_state: 'delivered')
            render :index
          end
        end

        class CancelledTab < OrdersTabs
          RailsAdmin::Config::Actions.register(self)

          register_instance_option :link_icon do
            'fa fa-remove'
          end
          register_instance_option :controller do
            proc do
              @objects = Order.where(aasm_state: 'cancelled')
              render :index
            end
          end
        end
      end
    end
  end
end
