namespace :migrate do
  desc 'Moves Ingredients from SQL to Mongo'

  task move_yeast: :environment do
    Db::Yeast.all.each do |yeast|

      id = "#{yeast.ye_yeid}"

      y = Beerinhand::Ingredients::Yeast.find_or_create_by_id(id)

      y.yeast =             yeast.ye_yeast
      y.type =              yeast.ye_type
      y.form =              yeast.ye_form
      y.laboratory =        yeast.ye_mfg
      y.lab_id =            yeast.ye_mfgno
      y.url =               yeast.ye_url
      y.floculation =       yeast.ye_floc
      y.tolerance =         yeast.ye_tolerance
      y.information =       yeast.ye_info
      y.attenuation =       yeast.ye_atten
      y.attenuation_low =   yeast.ye_atlow
      y.attenuation_high =  yeast.ye_athigh
      y.temp_low =          yeast.ye_templow
      y.temp_high =         yeast.ye_temphigh
      y.temp_units =        temp_unit_type(yeast.ye_tempunits)

      if y.valid?
        y.save!
        puts "Saved: #{id} #{yeast.ye_yeast}"

      else
        puts "failed: #{id} #{yeast.ye_yeast}"
        puts y.errors.messages
      end

    end
  end

  def temp_unit_type(type)
    return 'F' if type =~ /f/i
    'C'
  end

  task move_misc: :environment do
    Db::Misc.all.each do |misc|

      id = "#{misc.mi_miid}"

      m = Beerinhand::Ingredients::Miscellaneous.find_or_create_by_id(id)

      m.type        = misc.mi_type
      m.use         = misc.mi_use
      m.unit        = misc.mi_unit
      m.unit_type   = misc_unit_type(misc.mi_utype)
      m.phase       = misc.mi_phase
      m.information = misc.mi_info
      m.url         = misc.mi_url

      if m.valid?
        m.save!
        puts "Saved: #{id} #{misc.mi_type}"

      else
        puts "failed: #{id} #{misc.mi_type}"
        puts m.errors.messages
      end

    end
  end

  def misc_unit_type(type)
    return 'Weight' if type == 'W'
    'Volume'
  end

  task move_hops: :environment do
    Db::Hop.all.each do |hop|

      id = "#{hop.hp_hpid}"

      h = Beerinhand::Ingredients::Hop.find_or_create_by_id(id)

      h.hop           = hop.hp_hop
      h.aa_low        = hop.hp_aalow
      h.aa_high       = hop.hp_aahigh
      h.hsi           = hop.hp_hsi
      h.grown         = hop.hp_grown
      h.profile       = hop.hp_profile
      h.use           = hop.hp_use
      h.example       = hop.hp_example
      h.substitute    = hop.hp_sub
      h.information   = hop.hp_info
      h.url           = hop.hp_url
      h.dry           = hop.hp_dry
      h.aroma         = hop.hp_aroma
      h.bitter        = hop.hp_bitter
      h.finish        = hop.hp_finish

      if h.valid?
        h.save!
        puts "Saved: #{id} #{hop.hp_hop}"
      else
        puts "failed: #{id} #{hop.hp_hop}"
        puts h.errors.messages
      end

    end
  end

  task move_grains: :environment do
    Db::Grain.all.each do |grain|

      id = "#{grain.gr_grid}"

      f = Beerinhand::Ingredients::Fermentable.find_or_create_by_id(id)

      f.fermentable   = grain.gr_type
      f.lovibond      = grain.gr_lvb
      f.sgc           = grain.gr_sgc
      f.lintner       = grain.gr_lintner
      f.mash          = grain.gr_mash
      f.maltster      = grain.gr_maltster
      f.country       = grain.gr_country
      f.information   = grain.gr_info
      f.category      = grain.gr_cat
      f.url           = grain.gr_url
      f.mc            = grain.gr_mc
      f.fgdb          = grain.gr_fgdb
      f.cgdb          = grain.gr_cgdb
      f.fcdif         = grain.gr_fcdif
      f.protein       = grain.gr_protein

      if f.valid?
        f.save!
        puts "Saved: #{id} #{grain.gr_type}"
      else
        debugger
        puts "failed: #{id} #{grain.gr_type}"
        puts f.errors.messages
      end

    end
  end

end
