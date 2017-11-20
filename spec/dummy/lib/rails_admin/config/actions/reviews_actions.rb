module RailsAdmin
  module Config
    module Actions
      class ReviewsActions < RailsAdmin::Config::Actions::Base
        register_instance_option :member do
          true
        end
        register_instance_option :only do
          Review
        end
        register_instance_option :visible? do
          authorized?
        end
      end

      class ChangeToApproved < ReviewsActions
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          if bindings[:object].class.name == 'Review'
            bindings[:object].rejected? || bindings[:object].unprocessed?
          end
        end

        register_instance_option :link_icon do
          'fa fa-thumbs-o-up'
        end

        register_instance_option :controller do
          proc do
            if params[:id] && object.may_approve?
              object.approve!
              flash[:notice] = I18n.t('admin.actions.change_to_approved.flash.success')
            else
              flash[:error] = I18n.t('admin.actions.change_to_approved.flash.error')
            end
            redirect_to :back
          end
        end
      end

      class ChangeToRejected < ReviewsActions
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          if bindings[:object].class.name == 'Review'
            bindings[:object].approved? || bindings[:object].unprocessed?
          end
        end

        register_instance_option :link_icon do
          'fa fa-thumbs-o-down'
        end

        register_instance_option :controller do
          proc do
            if params[:id] && object.may_reject?
              object.reject!
              flash[:notice] = I18n.t('admin.actions.change_to_rejected.flash.success')
            else
              flash[:error] = I18n.t('admin.actions.change_to_rejected.flash.error')
            end
            redirect_to :back
          end
        end
      end
    end
  end
end
