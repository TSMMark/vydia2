namespace :db do
	desc "Fill databas with sample data"
	c = 10;
	task populate: :environment do
		10.times do |n|
			puts "[DEBUG] creating user #{n+1} of #{c}"
			name	= Faker::Name.name
			email	= "#{Faker::Name.first_name}-#{n+1}@example.com"
			password	= "password"
			User.create!(
				name: name,
				email: email,
				password: password,
				password_confirmation: password
			)
		end

		User.all.each do |user|
			puts "[DEBUG] uploading images for user #{user.id} of #{User.last.id}"
			10.times do |n|
				image				= File.open(Dir.glob(File.join(Rails.root,'sample_images', '*')).sample)
				description	= %w(cool smashing alright! wow awesome sweet hotttt excellent whoaaa nice incredible incred.).sample
				user.pins.create!(image:image, description:description)
			end
		end

	end
end