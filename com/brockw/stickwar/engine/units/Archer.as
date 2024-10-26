package com.brockw.stickwar.engine.units
{
   import com.brockw.game.*;
   import com.brockw.stickwar.engine.ActionInterface;
   import com.brockw.stickwar.engine.Ai.*;
   import com.brockw.stickwar.engine.Ai.command.*;
   import com.brockw.stickwar.engine.StickWar;
   import com.brockw.stickwar.engine.Team.*;
   import com.brockw.stickwar.market.*;
   import flash.display.*;
   import flash.geom.*;
   
   public class Archer extends RangedUnit
   {
       
      
      private var _isCastleArcher:Boolean;
      
      private var isFire:Boolean;
      
      private var archerFireSpellCooldown:SpellCooldown;
      
      private var arrowDamage:Number;
      
      private var bowFrame:int;
      
      private var normalRange:Number;
      
      private var fireArrowRange:Number;
      
      private var areaDamage:Number;
      
      private var area:Number;
      
      private var fireDamage:Number;
      
      private var fireFrames:int;
      
      public function Archer(param1:StickWar)
      {
         super(param1);
         _mc = new _archer();
         this.init(param1);
         addChild(_mc);
         ai = new ArcherAi(this);
         initSync();
         firstInit();
         this.archerFireSpellCooldown = new SpellCooldown(0,param1.xml.xml.Order.Units.archer.fire.cooldown,param1.xml.xml.Order.Units.archer.fire.mana);
      }
      
      public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
      {
         var _loc5_:_archer;
         if((_loc5_ = _archer(param1)).mc.archerBag)
         {
            if(param4 != "")
            {
               _loc5_.mc.archerBag.gotoAndStop(param4);
            }
         }
         if(_loc5_.mc.head)
         {
            if(param3 != "")
            {
               _loc5_.mc.head.gotoAndStop(param3);
            }
         }
      }
      
      override public function setActionInterface(param1:ActionInterface) : void
      {
         super.setActionInterface(param1);
         if(techTeam.tech.isResearched(Tech.ARCHIDON_FIRE))
         {
            param1.setAction(0,0,UnitCommand.ARCHER_FIRE);
         }
      }
      
      public function getFireCoolDown() : Number
      {
         return this.archerFireSpellCooldown.cooldown();
      }
      
      override public function init(param1:StickWar) : void
      {
         initBase();
         _maximumRange = this.normalRange = param1.xml.xml.Order.Units.archer.maximumRange;
         this.fireArrowRange = param1.xml.xml.Order.Units.archer.fire.range;
         maxHealth = health = param1.xml.xml.Order.Units.archer.health;
         this.createTime = param1.xml.xml.Order.Units.archer.cooldown;
         this.projectileVelocity = param1.xml.xml.Order.Units.archer.arrowVelocity;
         this.arrowDamage = param1.xml.xml.Order.Units.archer.damage;
         population = param1.xml.xml.Order.Units.archer.population;
         _mass = param1.xml.xml.Order.Units.archer.mass;
         _maxForce = param1.xml.xml.Order.Units.archer.maxForce;
         _dragForce = param1.xml.xml.Order.Units.archer.dragForce;
         _scale = param1.xml.xml.Order.Units.archer.scale;
         _maxVelocity = param1.xml.xml.Order.Units.archer.maxVelocity;
         this.fireDamage = param1.xml.xml.Order.Units.archer.fire.fireDamage;
         this.fireFrames = param1.xml.xml.Order.Units.archer.fire.fireFrames;
         this.loadDamage(param1.xml.xml.Order.Units.archer);
         this.areaDamage = 0;
         this.area = 0;
         if(this.isCastleArcher)
         {
            this._maximumRange = this.normalRange = param1.xml.xml.Order.Units.archer.castleRange;
            _scale *= 1.1;
            this.area = param1.xml.xml.Order.Units.archer.castleArea;
            this.areaDamage = param1.xml.xml.Order.Units.archer.castleAreaDamage;
         }
         type = Unit.U_ARCHER;
         _mc.stop();
         _mc.width *= _scale;
         _mc.height *= _scale;
         _state = S_RUN;
         MovieClip(_mc.mc.gotoAndPlay(1));
         MovieClip(_mc.gotoAndStop(1));
         drawShadow();
         this.isFire = false;
         this.bowFrame = 1;
      }
      
      override protected function loadDamage(param1:XMLList) : void
      {
         var _loc2_:Number = NaN;
         this.isArmoured = param1.armoured == 1 ? true : false;
         if(!this._isCastleArcher)
         {
            _loc2_ = Number(param1.damage);
            this._damageToArmour = _loc2_ + Number(param1.toArmour);
            this._damageToNotArmour = _loc2_ + Number(param1.toNotArmour);
         }
         else
         {
            _loc2_ = Number(param1.castleDamage);
            this._damageToArmour = _loc2_ + Number(param1.castleToArmour);
            this._damageToNotArmour = _loc2_ + Number(param1.castleToNotArmour);
         }
      }
      
      override public function setBuilding() : void
      {
         building = team.buildings["ArcheryBuilding"];
      }
      
      public function archerFireArrow() : void
      {
         if(Boolean(this.archerFireSpellCooldown.spellActivate(team)) && techTeam.tech.isResearched(Tech.ARCHIDON_FIRE))
         {
            this.isFire = true;
            takeBottomTrajectory = false;
            _maximumRange = this.fireArrowRange;
         }
      }
      
      override public function update(param1:StickWar) : void
      {
         super.update(param1);
         this.archerFireSpellCooldown.update();
         updateCommon(param1);
         if(!isDieing)
         {
            updateMotion(param1);
            if(_isDualing)
            {
               _mc.gotoAndStop(_currentDual.attackLabel);
               moveDualPartner(_dualPartner,_currentDual.xDiff);
               if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
               {
                  _isDualing = false;
                  _state = S_RUN;
                  px += Util.sgn(mc.scaleX) * _currentDual.finalXOffset * this.scaleX * this._scale * _worldScaleX * this.perspectiveScale;
                  dx = 0;
                  dy = 0;
               }
            }
            else if(_state == S_RUN)
            {
               if(isFeetMoving())
               {
                  _mc.gotoAndStop("run");
               }
               else
               {
                  _mc.gotoAndStop("stand");
               }
            }
            else if(_state == S_ATTACK)
            {
               if(MovieClip(_mc.mc).currentFrame > MovieClip(_mc.mc).totalFrames / 2 && !hasHit)
               {
                  hasHit = this.checkForHit();
               }
               if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
               {
                  _state = S_RUN;
               }
            }
         }
         else if(isDead == false)
         {
            isDead = true;
            if(_isDualing)
            {
               _mc.gotoAndStop(_currentDual.defendLabel);
            }
            else
            {
               _mc.gotoAndStop(getDeathLabel(param1));
            }
            this.team.removeUnit(this,param1);
         }
         if(isDead)
         {
            Util.animateMovieClip(_mc);
         }
         else
         {
            if(!isDead && MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
            {
               MovieClip(_mc.mc).gotoAndStop(1);
            }
            MovieClip(_mc.mc).nextFrame();
            _mc.mc.stop();
         }
         var _loc2_:MovieClip = _mc.mc.bow;
         if(_loc2_ != null)
         {
            _loc2_.gotoAndStop(this.bowFrame);
            if(this.bowFrame != 1)
            {
               if(this.bowFrame == 46)
               {
                  param1.soundManager.playSound("BowReady",px,py);
               }
               _loc2_.nextFrame();
               this.bowFrame += 1;
               if(_loc2_.currentFrame == _loc2_.totalFrames)
               {
                  _loc2_.gotoAndStop(1);
                  this.bowFrame = 1;
               }
            }
         }
         if(this.isCastleArcher)
         {
            Archer.setItem(mc,"Default","Basic Helmet","Default");
         }
         else if(!hasDefaultLoadout)
         {
            Archer.setItem(mc,team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
         }
         if(_mc.mc.bow != null)
         {
            _mc.mc.bow.rotation = bowAngle;
         }
      }
      
      override public function isLoaded() : Boolean
      {
         var _loc1_:MovieClip = _mc.mc.bow;
         return this.bowFrame < 35;
      }
      
      override public function shoot(param1:StickWar, param2:Unit) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         if(_state != S_ATTACK)
         {
            _loc3_ = _mc.mc.bow;
            if(this.bowFrame != 1)
            {
               return;
            }
            this.bowFrame += 1;
            _loc3_.nextFrame();
            _loc4_ = _loc3_.localToGlobal(new Point(0,0));
            _loc4_ = param1.battlefield.globalToLocal(_loc4_);
            _loc5_ = projectileVelocity;
            _loc6_ = int(this.arrowDamage);
            _loc7_ = 0;
            param1.soundManager.playSoundRandom("launchArrow",5,px,py);
            if(mc.scaleX < 0)
            {
               param1.projectileManager.initArrow(_loc4_.x,_loc4_.y,180 - bowAngle,_loc5_,param2.y,angleToTargetW(param2,_loc5_,angleToTarget(param2)),this,_loc6_,_loc7_,this.isFire,this.area,this.areaDamage,param2,this.fireDamage,this.fireFrames);
            }
            else
            {
               param1.projectileManager.initArrow(_loc4_.x,_loc4_.y,bowAngle,_loc5_,param2.y,angleToTargetW(param2,_loc5_,angleToTarget(param2)),this,_loc6_,_loc7_,this.isFire,this.area,this.areaDamage,param2,this.fireDamage,this.fireFrames);
            }
            this.isFire = false;
            _maximumRange = this.normalRange;
            takeBottomTrajectory = true;
         }
      }
      
      override public function aim(param1:Unit) : void
      {
         var _loc2_:Number = angleToTarget(param1);
         if(Math.abs(normalise(angleToBowSpace(_loc2_) - bowAngle)) < 10)
         {
            bowAngle += normalise(angleToBowSpace(_loc2_) - bowAngle) * 0.8;
         }
         else
         {
            bowAngle += normalise(angleToBowSpace(_loc2_) - bowAngle) * 0.1;
         }
      }
      
      override public function mayAttack(param1:Unit) : Boolean
      {
         var _loc2_:int = 200;
         if(!this.isCastleArcher && team.direction * px < team.direction * (this.team.homeX + team.direction * _loc2_))
         {
            return false;
         }
         if(isIncapacitated())
         {
            return false;
         }
         if(param1 == null)
         {
            return false;
         }
         if(this.isDualing == true)
         {
            return false;
         }
         if(aimedAtUnit(param1,angleToTarget(param1)) && this.inRange(param1))
         {
            return true;
         }
         return false;
      }
      
      override public function walk(param1:Number, param2:Number, param3:int) : void
      {
         if(isAbleToWalk())
         {
            baseWalk(param1,param2,param3);
         }
      }
      
      public function get isCastleArcher() : Boolean
      {
         return this._isCastleArcher;
      }
      
      public function set isCastleArcher(param1:Boolean) : void
      {
         if(param1)
         {
            this._maximumRange = 500;
            this.healthBar.visible = false;
            isStationary = true;
         }
         this._isCastleArcher = param1;
      }
   }
}
