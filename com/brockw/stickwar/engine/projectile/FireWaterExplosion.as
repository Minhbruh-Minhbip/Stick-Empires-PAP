package com.brockw.stickwar.engine.projectile
{
   import com.brockw.game.*;
   import com.brockw.stickwar.engine.*;
   import com.brockw.stickwar.engine.units.Unit;
   import flash.display.*;
   
   public class FireWaterExplosion extends Projectile
   {
       
      
      internal var spellMc:MovieClip;
      
      internal var explosionRadius:Number;
      
      internal var stunForce:Number;
      
      internal var explosionDamage:Number;
      
      internal var pushBack:Number;
      
      public function FireWaterExplosion(param1:StickWar)
      {
         super();
         type = FIRE_WATER_EXPLOSION;
         this.spellMc = new firewaterexplosionMc();
         this.addChild(this.spellMc);
         this.explosionRadius = param1.xml.xml.Elemental.Units.fireWater.range;
         this.pushBack = param1.xml.xml.Elemental.Units.fireWater.pushBack;
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         removeChild(this.spellMc);
         this.spellMc = null;
      }
      
      override public function update(param1:StickWar) : void
      {
         Util.animateMovieClipBasic(this.spellMc);
         this.scaleX = 1.7 * (param1.backScale + py / param1.map.height * (param1.frontScale - param1.backScale));
         this.scaleY = 1.7 * (param1.backScale + py / param1.map.height * (param1.frontScale - param1.backScale));
         var _loc2_:Array = team.enemyTeam.units;
         var _loc3_:int = int(_loc2_.length);
         if(this.spellMc.currentFrame == 3)
         {
            param1.spatialHash.mapInArea(px - this.explosionRadius,py - this.explosionRadius,px + this.explosionRadius,py + this.explosionRadius,this.damageUnit);
         }
      }
      
      private function damageUnit(param1:Unit) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1.team != this.team)
         {
            if(Math.pow(param1.px - this.px,2) + Math.pow(param1.py - this.py,2) < Math.pow(this.explosionRadius,2))
            {
               dz = dx = dy = 0;
               _loc2_ = Number(this.explosionDamage);
               _loc3_ = Number(this.explosionDamage);
               param1.damage(1,_loc2_,null);
               param1.setFire(burnFrames,burnDamage);
               param1.stun(stunTime,this.stunForce);
               if(!param1.isFreezing && !param1.isFrozen())
               {
                  param1.applyVelocity(Util.sgn(param1.px - this.px) * this.pushBack,0,0);
               }
            }
         }
      }
      
      override public function isReadyForCleanup() : Boolean
      {
         return this.spellMc.currentFrame == this.spellMc.totalFrames;
      }
      
      override public function isInFlight() : Boolean
      {
         return this.spellMc.currentFrame != this.spellMc.totalFrames;
      }
   }
}
