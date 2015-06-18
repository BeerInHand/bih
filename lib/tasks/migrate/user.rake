namespace :migrate do
  desc 'Moves users from SQL to Mongo'

  task move_users: :environment do
    Db::User.all.each do |user|

      id = "#{user.us_usid}"

      u = Beerinhand::User.find_or_create_by_id(id)

      u.user = user.us_user
      u.first = user.us_first
      u.last = user.us_last
      u.email = user.us_email
      u.pwd = user.us_pwd
      u.postal = user.us_postal
      u.defaults = {
        volume: user.us_volume,
        boil_volume: boil_volume(user),
        efficency: user.us_eff,
        hop_forms: user.us_hopform,
        hydro_temp: user.us_hydrotemp,
        primer: user.us_primer,
        privacy: user.us_privacy,
        recipe_type: user.us_mashtype,
        units: {
          grain_units: user.us_munits,
          gravity_units: user.us_eunits,
          hop_units: user.us_hunits,
          temp_units: user.us_tunits,
          volume_units: user.us_vunits
        }
      }

      if u.valid?
        u.save!
        puts "Saved: #{id} #{user.us_user}"
      else
        puts "failed: #{id} #{user.us_user}"
        puts u.errors.messages
      end
    end
  end

  def boil_volume(user)
    return user.us_volume if user.us_boilvol.zero?
    user.us_boilvol
  end
end
