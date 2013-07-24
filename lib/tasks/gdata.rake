namespace :video do
	desc "Fetch YouTube gdata for videos added previously"

	task gdata: :environment do
		total = Video.count
		Video.all.each do |v|
			puts "[DEBUG] gdata for video #{v.id} of #{total}"
			gdata = Youtube.new v.token
      v.yt_title          ||= gdata.title
      v.yt_thumb          ||= gdata.thumb
      v.yt_rating         ||= gdata.rating_100
      v.yt_view_count     ||= gdata.view_count
      v.yt_favorite_count ||= gdata.favorite_count
      v.yt_published      ||= gdata.published
      v.save
		end
	end

end