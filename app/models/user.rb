# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# 1. Tareas propias (CAMBIO DE NOMBRE: de :owned_tasks a :tasks)
  # Al llamarla ':tasks', cuando hagas user.tasks, Rails sabrá que eres el dueño.
  has_many :tasks, class_name: 'Task', foreign_key: 'owner_id', dependent: :destroy

  # 2. Relación intermedia
  has_many :participations, class_name: 'Participant'

  # 3. Tareas donde participo (CAMBIO DE NOMBRE: de :tasks a :participating_tasks)
  # Agregamos source: :task para decirle que busque en la tabla 'tasks'
  has_many :participating_tasks, through: :participations, source: :task
end
