# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  first_name       :string
#  last_name        :string
#  email            :string
#  business_account :boolean
#  group_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  password_digest  :string
#

class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :validate_user, except: [:new, :create]
  skip_before_action :authorized?, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)
    @group = User.find_group(@user.email) if @user.business_account?
    @user.group = @group if @group

    if @user.save
      session[:user_id] = @user.id
      redirect_to @group || @user
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(edit_user_params)
      redirect_to @user.group
    else
      render 'edit'
    end
  end

  private

  def new_user_params
    params.require(:user).permit(
      :first_name, :last_name, :email,
      :password,:password_confirmation, :business_account
    )
  end

  def edit_user_params
    params.require(:user).permit(
      :first_name, :last_name, :password,:password_confirmation
    )
  end

  def find_user
    @user = User.find(params[:id])
  end
end
