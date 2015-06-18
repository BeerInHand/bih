class Db::Recipe < ActiveRecord::Base
  belongs_to :user, :foreign_key => "re_usid"

  has_many :recipegrains, :foreign_key => "rg_reid"
  has_many :recipehops, :foreign_key => "rh_reid"
  has_many :recipeyeasts, :foreign_key => "ry_reid"
  has_many :recipemiscs, :foreign_key => "rm_reid"
  has_many :recipedates, :foreign_key => "rd_reid"
  accepts_nested_attributes_for :recipegrains, :allow_destroy => true
  accepts_nested_attributes_for :recipehops, :allow_destroy => true
  accepts_nested_attributes_for :recipeyeasts, :allow_destroy => true
  accepts_nested_attributes_for :recipemiscs, :allow_destroy => true
  accepts_nested_attributes_for :recipedates, :allow_destroy => true

  self.primary_key = :re_reid

  def expabv
    5.00
  end

  def fetch
    resp = emptyResponse
    resp["DATA"] = { "RCP"=>gonRecipe, "METHOD"=>"Fetch" }
    resp
  end

  def self.transform(rcpdata)
    row = rcpdata[:qryRecipe][:DATA]["0"]
    row[:RE_BREWED] = Date.strptime(row[:RE_BREWED], "%m/%d/%Y")
    rcp = {
      :id=>row[:RE_REID].to_i, :name=>row[:RE_NAME], :volume=>row[:RE_VOLUME].to_f, :boilvol=>row[:RE_BOILVOL].to_f, :style=>row[:RE_STYLE],
      :eff=>row[:RE_EFF].to_i, :expgrv=>row[:RE_EXPGRV].to_f, :expsrm=>row[:RE_EXPSRM].to_f, :expibu=>row[:RE_EXPIBU].to_f,
      :vunits=>row[:RE_VUNITS], :munits=>row[:RE_MUNITS], :hunits=>row[:RE_HUNITS], :tunits=>row[:RE_TUNITS], :recipetype=>row[:RE_TYPE],
      :mashtype=>row[:RE_MASHTYPE], :notes=>row[:RE_NOTES], :mash=>row[:RE_MASH], :prime=>row[:RE_PRIME], :grnamt=>row[:RE_GRNAMT].to_f,
      :mashamt=>row[:RE_MASHAMT].to_f, :hopamt=>row[:RE_HOPAMT].to_f, :hopcnt=>row[:RE_HOPCNT].to_i, :prime=>row[:RE_GRNCNT].to_i,
      :eunits=>row[:RE_EUNITS], :brewed=>row[:RE_BREWED], :privacy=>row[:RE_PRIVACY]
    }
    rcp[:recipegrains_attributes] = []
    rcp[:recipehops_attributes] = []
    rcp[:recipedates_attributes] = []
    rcp[:recipemiscs_attributes] = []
    rcp[:recipeyeasts_attributes] = []

    rcp[:recipegrains_attributes] = rcpdata[:qryRecipeGrains][:DATA].map do | row |
      row[1][:RG_RGID]=nil if row[1][:RG_RGID]==0
      {
        :id=>row[1][:RG_RGID], :amount=>row[1][:RG_AMOUNT], :lvb=>row[1][:RG_LVB], :maltster=>row[1][:RG_MALTSTER], :mash=>row[1][:RG_MASH], :pct=>row[1][:RG_PCT],
        :sgc=>row[1][:RG_SGC], :graintype=>row[1][:RG_TYPE], :user_id=>row[1][:RG_USID], '_destroy'=>(row[1][:_DELETED]=="false" ? 0 : 1)
      }
    end if rcpdata[:qryRecipeGrains].has_key? :DATA

    rcp[:recipehops_attributes] = rcpdata[:qryRecipeHops][:DATA].map do | row |
      row[1][:RH_RHID]=nil if row[1][:RH_RHID]=='0'
      {
        :id=>row[1][:RH_RHID], :aau=>row[1][:RH_AAU], :amount=>row[1][:RH_AMOUNT], :form=>row[1][:RH_FORM], :grown=>row[1][:RH_GROWN], :hop=>row[1][:RH_HOP],
        :ibu=>row[1][:RH_IBU], :recipe_id=>row[1][:RH_REID], :boiltime=>row[1][:RH_TIME], :user_id=>row[1][:RH_USID], :when=>row[1][:RH_WHEN],
        '_destroy'=>(row[1][:_DELETED]=="false" ? 0 : 1)
      }
    end if rcpdata[:qryRecipeHops].has_key? :DATA

    rcp[:recipedates_attributes] = rcpdata[:qryRecipeDates][:DATA].map do | row |
      row[1][:RD_RDID]=nil if row[1][:RD_RDID]=='0'
      row[1][:RD_DATE] = Date.strptime(row[1][:RD_DATE], "%m/%d/%Y")
      {
        :id=>row[1][:RD_RDID], :entrydate=>row[1][:RD_DATE], :gravity=>row[1][:RD_GRAVITY], :note=>row[1][:RD_NOTE], :recipe_id=>row[1][:RD_REID],
        :temp=>row[1][:RD_TEMP], :entrytype=>row[1][:RD_TYPE], :user_id=>row[1][:RD_USID], '_destroy'=>(row[1][:_DELETED]=="false" ? 0 : 1)
      }
    end if rcpdata[:qryRecipeDates].has_key? :DATA

    rcp[:recipemiscs_attributes] = rcpdata[:qryRecipeMisc][:DATA].map do | row |
      row[1][:RM_RMID]=nil if row[1][:RM_RMID]=='0'
      {
        :id=>row[1][:RM_RMID], :action=>row[1][:RM_ACTION], :added=>row[1][:RM_ADDED], :amount=>row[1][:RM_AMOUNT], :note=>row[1][:RM_NOTE],
        :offset=>row[1][:RM_OFFSET], :phase=>row[1][:RM_PHASE], :recipe_id=>row[1][:RM_REID], :sort=>row[1][:RM_SORT], :misctype=>row[1][:RM_TYPE],
        :unit=>row[1][:RM_UNIT], :user_id=>row[1][:RM_USID], :utype=>row[1][:RM_UTYPE], '_destroy'=>(row[1][:_DELETED]=="false" ? 0 : 1)
      }
    end if rcpdata[:qryRecipeMisc].has_key? :DATA

    rcp[:recipeyeasts_attributes] = rcpdata[:qryRecipeYeast][:DATA].map do | row |
      row[1][:RY_RYID]=nil if row[1][:RY_RYID]=='0'
      {
        :id=>row[1][:RY_RYID], :entrydate=>row[1][:RY_DATE], :mfg=>row[1][:RY_MFG], :mfgno=>row[1][:RY_MFGNO], :note=>row[1][:RY_NOTE],
        :recipe_id=>row[1][:RY_REID], :user_id=>row[1][:RY_USID], :yeast=>row[1][:RY_YEAST], '_destroy'=>(row[1][:_DELETED]=="false" ? 0 : 1)
      }
    end if rcpdata[:qryRecipeYeast].has_key? :DATA
    rcp
  end

  def seed

    fermentables = self.recipegrains.map.with_index do |recipegrain,  idx|
      %Q[{ fermentable: "#{recipegrain.graintype}", amount: "#{recipegrain.amount}",  sgc: "#{recipegrain.sgc}", lovibond: "#{recipegrain.lvb}",  mash: "#{recipegrain.mash}", maltster: "#{recipegrain.maltster}" } ]
    end.join(",")

    hops = self.recipehops.map.with_index do |recipehop,  idx|
      %Q[{ hop: "#{recipehop.hop}", aau: "#{recipehop.aau}", amount: "#{recipehop.amount}", form: "#{recipehop.form}", boil_time: "#{recipehop.boiltime}", grown: "#{recipehop.grown}", when: "#{recipehop.when}" } ]
    end.join(",")

    events = self.recipedates.map.with_index do |recipedate,  idx|
      %Q[{ event_at: "#{recipedate.entrydate}", type: "#{recipedate.entrytype}", gravity: "#{recipedate.gravity}", temperature: "#{recipedate.temp}", note: "#{recipedate.note}" } ]
    end.join(",")

    miscs = self.recipemiscs.map.with_index do |recipemisc,  idx|
      %Q[{ type: "#{recipemisc.misctype}", amount: "#{recipemisc.amount}", unit: "#{recipemisc.unit}", unit_type: "#{recipemisc.utype}", note: "#{recipemisc.note}", phase: "#{recipemisc.phase}", action: "#{recipemisc.action}", offset: "#{recipemisc.offset}", added: "#{recipemisc.added}", sort: "#{recipemisc.sort}" } ]
    end.join(",")

    yeasts = self.recipeyeasts.map.with_index do |recipeyeast,  idx|
      %Q[{ yeast: "#{recipeyeast.yeast}", laboratory: "#{recipeyeast.mfg}", lab_id: "#{recipeyeast.mfgno}", pitched_at: "#{recipeyeast.entrydate}", note: "#{recipeyeast.note}" } ]
    end.join(",")

    %Q[Recipe.new({ boil_volume: "#{boilvol}", efficency: "#{eff}", gravity: "#{expgrv}", ibu: "#{expibu}", mash: "#{mash}", name: "#{name}", primer: "#{prime}", privacy: "#{privacy}", recipe_type: "#{mashtype}", srm: "#{expsrm}", style: "#{style}", style_type: "#{recipetype}", user_id: "#{user_id}", volume: "#{volume}", units: { gravity_units: "#{eunits}", hop_units: "#{hunits}", grain_units: "#{munits}", temp_units: "#{tunits}", volume_units: "#{vunits}" }, fermentables: [#{fermentables}], hops: [#{hops}], events: [#{events}], miscs: [#{miscs}], yeasts: [#{yeasts}] }).save!]

  end


  def gonRecipe
    qryRecipe = {
      "RE_REID" => self.id,  "RE_USID" => self.user_id,  "RE_NAME" => self.name,  "RE_VOLUME" => self.volume.to_s.to_f,  "RE_BOILVOL" => self.boilvol,
      "RE_STYLE" => self.style,  "RE_EFF" => self.eff,  "RE_EXPGRV" => self.expgrv,  "RE_EXPSRM" => self.expsrm,  "RE_EXPIBU" => self.expibu,
      "RE_VUNITS" => self.vunits,  "RE_MUNITS" => self.munits,  "RE_HUNITS" => self.hunits,  "RE_TUNITS" => self.tunits,  "RE_BREWED" => self.brewed,
      "RE_TYPE" => self.recipetype,  "RE_MASHTYPE" => self.mashtype,  "RE_NOTES" => self.notes,  "RE_MASH" => self.mash,  "RE_PRIME" => self.prime,
      "RE_GRNAMT" => self.grnamt,  "RE_MASHAMT" => self.mashamt,  "RE_HOPAMT" => self.hopamt,  "RE_HOPCNT" => self.hopcnt,  "RE_GRNCNT" => self.grncnt,
      "RE_EUNITS" => self.eunits,  "RE_PRIVACY" => self.privacy,  "RE_DLA" => self.updated_at,  "RE_EXPABV" => self.expabv,
      "_DELETED" =>false,  "_ROWID" =>0
    }
    qryRecipeGrains = self.recipegrains.map.with_index do |recipegrain,  idx|
      {
        "RG_RGID" => recipegrain.id,  "RG_REID" => recipegrain.recipe_id,  "RG_USID" => recipegrain.user_id,  "RG_TYPE" => recipegrain.graintype,
        "RG_AMOUNT" => recipegrain.amount,  "RG_SGC" => recipegrain.sgc,  "RG_LVB" => recipegrain.lvb,  "RG_MASH" => recipegrain.mash,
        "RG_MALTSTER" => recipegrain.maltster,  "RG_PCT" => recipegrain.pct,
        "_DELETED" =>false,  "_ROWID" =>idx
      }
    end
    qryRecipeHops = self.recipehops.map.with_index do |recipehop,  idx|
      {
        "RH_RHID" => recipehop.id,  "RH_REID" => recipehop.recipe_id, "RH_USID" => recipehop.user_id, "RH_HOP" => recipehop.hop,
        "RH_AAU" => recipehop.aau, "RH_AMOUNT" => recipehop.amount, "RH_FORM" => recipehop.form, "RH_TIME" => recipehop.boiltime,
        "RH_IBU" => recipehop.ibu, "RH_GROWN" => recipehop.grown, "RH_WHEN" => recipehop.when,
        "_DELETED" =>false,  "_ROWID" =>idx
      }
    end
    qryRecipeDates = self.recipedates.map.with_index do |recipedate,  idx|
      {
        "RD_RDID" => recipedate.id, "RD_REID" => recipedate.recipe_id, "RD_USID" => recipedate.user_id, "RD_DATE" => recipedate.entrydate,
        "RD_TYPE" => recipedate.entrytype, "RD_GRAVITY" => recipedate.gravity, "RD_TEMP" => recipedate.temp, "RD_NOTE" => recipedate.note,
        "_DELETED" =>false,  "_ROWID" =>idx
      }
    end
    qryRecipeMisc = self.recipemiscs.map.with_index do |recipemisc,  idx|
      {
        "RM_RMID" => recipemisc.id,  "RM_REID" => recipemisc.recipe_id, "RM_USID" => recipemisc.user_id, "RM_TYPE" => recipemisc.misctype,
        "RM_AMOUNT" => recipemisc.amount, "RM_UNIT" => recipemisc.unit, "RM_UTYPE" => recipemisc.utype, "RM_NOTE" => recipemisc.note,
        "RM_PHASE" => recipemisc.phase, "RM_ACTION" => recipemisc.action, "RM_OFFSET" => recipemisc.offset, "RM_ADDED" => recipemisc.added,
        "RM_SORT" => recipemisc.sort,
        "_DELETED" =>false,  "_ROWID" =>idx
      }
    end
    qryRecipeYeast = self.recipeyeasts.map.with_index do |recipeyeast,  idx|
      {
        "RY_RYID" => recipeyeast.id, "RY_REID" => recipeyeast.recipe_id, "RY_USID" => recipeyeast.user_id, "RY_YEAST" => recipeyeast.yeast,
        "RY_MFG" => recipeyeast.mfg, "RY_MFGNO" => recipeyeast.mfgno, "RY_DATE" => recipeyeast.entrydate, "RY_NOTE" => recipeyeast.note,
        "_DELETED" =>false,  "_ROWID" =>idx
      }
    end
    {
      "qryRecipe" => {
        "COLUMNS" => ["RE_REID", "RE_USID", "RE_NAME", "RE_VOLUME", "RE_BOILVOL", "RE_STYLE", "RE_EFF", "RE_EXPGRV", "RE_EXPSRM", "RE_EXPIBU", "RE_VUNITS", "RE_MUNITS", "RE_HUNITS", "RE_TUNITS", "RE_BREWED", "RE_TYPE", "RE_MASHTYPE", "RE_NOTES", "RE_MASH", "RE_PRIME", "RE_GRNAMT", "RE_MASHAMT", "RE_HOPAMT", "RE_HOPCNT", "RE_GRNCNT", "RE_EUNITS", "RE_PRIVACY", "RE_DLA", "RE_EXPABV"],
        "DATA" => [qryRecipe]
      },
      "qryRecipeGrains" => {
        "COLUMNS" => ["RG_RGID", "RG_REID", "RG_USID", "RG_TYPE", "RG_AMOUNT", "RG_SGC", "RG_LVB", "RG_MASH", "RG_MALTSTER", "RG_PCT"],
        "DATA" => qryRecipeGrains
      },
      "qryRecipeHops" => {
        "COLUMNS" => ["RH_RHID", "RH_REID", "RH_USID", "RH_HOP", "RH_AAU", "RH_AMOUNT", "RH_FORM", "RH_TIME", "RH_IBU", "RH_GROWN", "RH_WHEN"],
        "DATA" => qryRecipeHops
      },
      "qryRecipeDates" => {
        "COLUMNS" => ["RD_RDID", "RD_REID", "RD_USID", "RD_DATE", "RD_TYPE", "RD_GRAVITY", "RD_TEMP", "RD_NOTE"],
        "DATA" => qryRecipeDates
      },
      "qryRecipeMisc" => {
        "COLUMNS" => ["RM_RMID", "RM_REID", "RM_USID", "RM_TYPE", "RM_AMOUNT", "RM_UNIT", "RM_UTYPE", "RM_NOTE", "RM_PHASE", "RM_ACTION", "RM_OFFSET", "RM_ADDED", "RM_SORT"],
        "DATA" => qryRecipeMisc
      },
      "qryRecipeYeast" => {
        "COLUMNS" => ["RY_RYID", "RY_REID", "RY_USID", "RY_YEAST", "RY_MFG", "RY_MFGNO", "RY_DATE", "RY_NOTE"      ],
        "DATA" => qryRecipeYeast
      }
    }
  end


  def self.getBrewLog(recipes)
    qryBrewLog = recipes.map.with_index do |recipe, idx|
      {"RE_HUNITS"=>recipe.hunits,"RE_EFF"=>recipe.eff,"RE_EXPSRM"=>recipe.expsrm.to_s.to_f,"RE_VUNITS"=>recipe.vunits,"RE_STYLE"=>recipe.style,
       "RE_EXPIBU"=>recipe.expibu.to_s.to_f,"RE_EUNITS"=>recipe.eunits,"RE_VOLUME"=>recipe.volume.to_s.to_f,"RE_BREWED"=>recipe.brewed.to_s,
       "RE_REID"=>recipe.id,"RE_NAME"=>recipe.name,"RE_MUNITS"=>recipe.munits,"RE_PRIVACY"=>recipe.privacy,"RE_EXPGRV"=>recipe.expgrv.to_s.to_f,
       "RE_USID"=>recipe.user_id, "_DELETED"=>false,"_ROWID"=>idx}
    end
    {
      "COLUMNS"=>["RE_BREWED","RE_EFF","RE_EUNITS","RE_EXPGRV","RE_EXPIBU","RE_EXPSRM","RE_HUNITS","RE_MUNITS","RE_NAME","RE_PRIVACY","RE_REID","RE_STYLE","RE_VOLUME","RE_VUNITS","RE_USID"],
      "DATA"=>qryBrewLog
    }
  end

end
