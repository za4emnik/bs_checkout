module RailsAdmin
  module Config
    module Actions
      class ReviewsTabs < RailsAdmin::Config::Actions::Base
        register_instance_option :collection do
          true
        end
        register_instance_option :only do
          Review
        end
        register_instance_option :visible? do
          authorized?
        end
      end

      class NewTabReview < ReviewsTabs
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :link_icon do
          'fa fa-comment'
        end

        register_instance_option :controller do
          proc do
            @objects = Review.where(aasm_state: 'unprocessed')
            render :index
          end
        end
      end

      class ProcessTabReview < ReviewsTabs
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :link_icon do
          'fa fa-check-square'
        end

        register_instance_option :controller do
          proc do
            @objects = Review.where(aasm_state: %w[approved rejected])
            render :index
          end
        end
      end
    end
  end
end
