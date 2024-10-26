package com.brockw.stickwar.engine.projectile
{
   import com.brockw.game.*;
   import com.brockw.stickwar.engine.*;
   import com.brockw.stickwar.engine.units.Unit;
   import flash.display.*;
   
   public class Nuke extends Projectile
   {
       
      
      internal var spellMc:MovieClip;
      
      internal var explosionRadius:Number;
      
      internal var explosionDamage:Number;
      
      public function Nuke(param1:StickWar)
      {
         super();
         type = NUKE;
         this.spellMc = new explosionBomber();
         this.addChild(this.spellMc);
         this.explosionRadius = param1.xml.xml.Chaos.Units.bomber.explosionRadius;
         this.explosionDamage = param1.xml.xml.Chaos.Units.bomber.explosionDamage;
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         removeChild(this.spellMc);
         this.spellMc = null;
      }
      
      override public function update(param1:StickWar) : void
      {
         Util.animateMovieClip(this.spellMc,4);
         this.scaleX = 1 * (param1.backScale + py / param1.map.height * (param1.frontScale - param1.backScale));
         this.scaleY = 1 * (param1.backScale + py / param1.map.height * (param1.frontScale - param1.backScale));
         var _loc2_:Array = team.enemyTeam.units;
         var _loc3_:int = int(_loc2_.length);
         if(this.spellMc.explosion.currentFrame == 3)
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
            }
         }
      }
      
      override public function isReadyForCleanup() : Boolean
      {
         return this.spellMc.explosion.currentFrame == this.spellMc.explosion.totalFrames;
      }
      
      override public function isInFlight() : Boolean
      {
         return this.spellMc.explosion.currentFrame != this.spellMc.explosion.totalFrames;
      }
   }
}
