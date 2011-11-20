# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
    user.name                                  "Michael Hartl"
    user.email                                  "mhartl@example.com"
    user.password                           "foobar"
    user.password_confirmation      "foobar"
    # user.microposts {|microposts| [microposts.association(:micropost)]}
end

Factory.sequence :email do |n|
    "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.association :user
  micropost.content "Foo bar"
end

Factory.define :user_with_micropost, :parent => :user do |user|
  user.after_create { |u| Factory(:micropost, :user => u) }
end
 

  
