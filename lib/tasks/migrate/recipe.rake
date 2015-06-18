namespace :migrate do
  desc 'Moves recipes from SQL to Mongo'

  task move_recipe: :environment do
    Db::Recipe.limit(1000).each do |recipe|

      id = "#{recipe.re_usid * 100}_#{recipe.re_reid * 100}"

      r = Beerinhand::Recipe.find_or_create_by_id(id)

      r.user_id =      recipe.re_usid
      r.name =         recipe.re_name
      r.volume =       recipe.re_volume
      r.boil_volume =  recipe.re_boilvol
      r.style =        recipe.re_style
      r.recipe_type =  recipe.re_mashtype
      r.efficency =    recipe.re_eff
      r.gravity =      recipe.re_expgrv
      r.srm =          recipe.re_expsrm
      r.ibu =          recipe.re_expibu
      r.mash =         recipe.re_mash
      r.primer =       recipe.re_prime
      r.privacy =      recipe.re_privacy
      r.created_at =   recipe.re_added
      r.updated_at =   recipe.re_dla

      r.units = build_units(recipe)
      r.fermentables = build_grains(recipe.recipegrains)
      r.hops = build_hops(recipe.recipehops)
      r.miscs = build_miscs(recipe.recipemiscs)
      r.events = build_events(recipe.recipedates)
      r.yeasts = build_yeasts(recipe.recipeyeasts)

      if r.valid?
        r.save!
        puts "Saved: #{id} #{recipe.re_name}"
      else
        puts "failed: #{id} #{recipe.re_name}"
        puts r.errors.messages
        dump_errors(r.fermentables)
        dump_errors(r.hops)
        dump_errors(r.miscs)
        dump_errors(r.events)
        debugger
        dump_errors(r.yeasts)
      end

    end
  end

  def dump_errors(objs)
    objs.each {|obj| puts obj.errors.messages if obj.errors.messages.present? }
  end

  def build_units(recipe)
    {
      grain_units: recipe.re_munits,
      gravity_units: recipe.re_eunits,
      hop_units: recipe.re_hunits,
      temp_units: recipe.re_tunits,
      volume_units: recipe.re_vunits
    }
  end

  def build_grains(grains)
    grains.map do |grain|
      {
        fermentable: grain.rg_type,
        amount: grain.rg_amount,
        sgc: grain.rg_sgc,
        lovibond: grain.rg_lvb,
        mash: grain.rg_mash,
        maltster: grain.rg_maltster,
        percent: grain.rg_pct
      }

    end
  end

  def build_hops(hops)
    hops.map do |hop|
      {
        hop: hop.rh_hop,
        aau: hop.rh_aau,
        amount: hop.rh_amount,
        form: hop.rh_form,
        boiled: hop.rh_time,
        grown: hop.rh_grown,
        phase: hop_phase(hop.rh_when)
      }
    end
  end

  def hop_phase(phase)
    return 'Boil' unless phase.present?
    return 'FWH' if phase == 'Fwh'
    phase
  end

  def build_miscs(miscs)
    miscs.map do |misc|
      {
        type: misc.rm_type,
        amount: misc.rm_amount,
        unit: misc.rm_unit,
        unit_type: misc_unit_type(misc.rm_utype),
        note: misc.rm_note,
        phase: misc.rm_phase,
        action: misc.rm_action,
        offset: misc.rm_offset,
        added: misc.rm_added,
        sort: misc.rm_sort
      }
    end
  end

  def misc_unit_type(type)
    return 'Weight' if type == 'W'
    'Volume'
  end

  def build_events(events)
    events.map do |event|
      {
        event_at: event.rd_date,
        type: event.rd_type,
        gravity: event.rd_gravity,
        temperature: event.rd_temp,
        note: event.rd_note
      }
    end
  end

  def build_yeasts(yeasts)
    yeasts.map do |yeast|
      {
        yeast: yeast.ry_yeast,
        laboratory: yeast.ry_mfg,
        lab_id: yeast.ry_mfgno,
        pitched_at: yeast.ry_date,
        note: yeast.ry_note
      }
    end
  end

end
