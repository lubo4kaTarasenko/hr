# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def users_seeds
  first_names = %w[Anna Vasya Grisha Kolya Dasha Valera Oleg]
  last_names = %w[Annasan Vasyasan Grishasan Kolyasan Dashasan Valerasan Olegsan]
  categories = %w[rails react html css angular php phyton c]
  levels = ['junior', 'middle', 'senior']
  ENGLISH_LEVELS = %w[none beginner pre-intermediate intermediate upper-intermediate advanced].freeze
  #emails = 

  20.times do
    u = User.create!(
      email: ("#{first_names.sample.downcase}#{rand(999)}@gmail.com"), 
      english_level: ENGLISH_LEVELS.sample,
      password: '1234567890'   
    )
    personal_data = PersonalInfo.create!(
      first_name: first_names.sample,
      last_name: last_names.sample
    )
    skill = Skill.create!(
      level: levels.sample,
      category: categories.sample
    )
  # u.add_role :master
    u.update!(personal_info: personal_data, skills: [skill] )
    
  end
end

#######################################
  u = User.create!(
      email: ("devops2@gmail.com"), 
      english_level: 'intermediate',
      password: 'password'   
    )
    personal_data = PersonalInfo.create!(
      first_name: 'devops2',
      last_name: 'devops2'
    )
    skill = Skill.create!(
      level: 'senior',
      category: 'devops'
    )
    

    u.add_role :devops
    u.update!(personal_info: personal_data, skills: [skill] )
#################################################
users = [ '602518cfa8bd5f001d00000f','602516d4a8bd5f001d000002' ]
project = Project.create!(
  name: 'greate', 
  users: users.map { |id| User.find(id) }
)




