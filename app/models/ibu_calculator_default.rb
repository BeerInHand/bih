class IbuCalculatorDefault
  attr_reader: :hop

  def initialize(hop)

  end

def ibuAmountFromIBU(VolumeUnits, VolumeIn, GravityUnits, GravityIn, WeightUnits, IBUs, HopAAU, HopForm, BoilLength, When, BoilVolumeIn) 
  VolumeIn = parseFloat(VolumeIn) || 0;
  GravityIn = parseFloat(GravityIn) || 1;
  IBUs = parseFloat(IBUs) || 0;
  HopAAU = parseFloat(HopAAU) || 0;
  BoilLength = parseFloat(BoilLength) || 0;
  BoilVolumeIn = parseFloat(BoilVolumeIn) || 0;
  var UtilPCT = ibuGetUtilization(HopForm, BoilLength, When);
  if (VolumeIn==0 || IBUs==0 || HopAAU==0 || UtilPCT==0) return 0;
  var VolumeInLiters = convertVolume(VolumeUnits, VolumeIn, "Liters");
  var GravityCorrection = ibuCorrectionForGravity(GravityUnits, GravityIn, VolumeIn, BoilVolumeIn);
  var WeightInGrams = ((VolumeInLiters * GravityCorrection * IBUs) / (UtilPCT / 100 * HopAAU / 100 * 1000));
  return convertWeight("Grams", WeightInGrams, WeightUnits);
end

def ibuCorrectionForGravity(GravityUnits, GravityIn, VolumeIn, BoilVolumeIn) 
  var GravityInSG = convertGravity(GravityUnits, GravityIn, "SG");
  if (BoilVolumeIn>0 && BoilVolumeIn!=VolumeIn) {
    GravityInSG = 1 + (VolumeIn / BoilVolumeIn) * (GravityInSG - 1);
  }
  if (GravityInSG>1.05) return 1 + (GravityInSG - 1.05) / 0.2;
  return 1;
end
def ibuGetUtilization(HopForm, BoilLength, When) 
  if (When=="FWH") return (HopForm=="Pellet" ? 32 : 30);
  if (When=="Dry") return 0;
  if (When=="Mash") return 15;
  if (BoilLength <= 15) return BoilLength / 15 * (HopForm=="Pellet" ? 12 : 10);
  if (BoilLength <= 30) return BoilLength / 30 * (HopForm=="Pellet" ? 22 : 20);
  if (BoilLength <= 45) return BoilLength / 45 * (HopForm=="Pellet" ? 26 : 24);
  if (BoilLength <= 60) return BoilLength / 60 * (HopForm=="Pellet" ? 28 : 26);
  if (BoilLength <= 90) return BoilLength / 90 * (HopForm=="Pellet" ? 32 : 30);
  return (HopForm=="Pellet" ? 32 : 30);
end

def ibuIBUFromAmount(VolumeUnits, VolumeIn, GravityUnits, GravityIn, WeightUnits, HopWeight, HopAAU, HopForm, BoilLength, When, BoilVolumeIn) 
  VolumeIn = parseFloat(VolumeIn) || 0;
  GravityIn = parseFloat(GravityIn) || 1;
  HopWeight = parseFloat(HopWeight) || 0;
  HopAAU = parseFloat(HopAAU) || 0;
  BoilLength = parseFloat(BoilLength) || 0;
  BoilVolumeIn = parseFloat(BoilVolumeIn) || 0;
  if (VolumeIn==0 || HopWeight==0 || HopAAU==0) return 0;
  var VolumeInLiters = convertVolume(VolumeUnits, VolumeIn, "Liters");
  var GravityCorrection = ibuCorrectionForGravity(GravityUnits, GravityIn, VolumeIn, BoilVolumeIn);
  var WeightInGrams = convertWeight(WeightUnits, HopWeight, "Grams");
  var UtilPCT = ibuGetUtilization(HopForm, BoilLength, When);
  return (WeightInGrams * UtilPCT / 100 * HopAAU / 100 * 1000) / (VolumeInLiters * GravityCorrection);
end

end
