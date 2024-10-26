package com.brockw.stickwar.singleplayer
{
   import com.brockw.stickwar.BaseMain;
   import com.brockw.stickwar.engine.*;
   import com.brockw.stickwar.engine.Ai.*;
   import com.brockw.stickwar.engine.Ai.command.*;
   import com.brockw.stickwar.engine.Team.Team;
   import com.brockw.stickwar.engine.multiplayer.moves.*;
   import com.brockw.stickwar.engine.units.*;
   import flash.utils.Dictionary;
   
   public class EnemyTeamAi
   {
       
      
      protected var isAttacking:Boolean;
      
      protected var team:Team;
      
      protected var unitComposition:Dictionary;
      
      private var mines:Array;
      
      private var isCreatingUnits:Boolean;
      
      public function EnemyTeamAi(param1:Team, param2:BaseMain, param3:StickWar, param4:* = true)
      {
         super();
         this.team = param1;
         this.isCreatingUnits = param4;
         this.isAttacking = false;
      }
      
      public function update(param1:StickWar) : void
      {
         this.team.calculateStatistics();
         this.team.enemyTeam.calculateStatistics();
         this.updateMiners(param1);
         this.rebalanceMiners(param1);
         this.updateGlobalStrategy(param1);
         if(this.isCreatingUnits)
         {
            this.updateUnitCreation(param1);
         }
         this.updateSpellCasters(param1);
      }
      
      protected function updateMiners(param1:StickWar) : void
      {
         var _loc3_:Miner = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.team.unitGroups[this.team.getMinerType()])
         {
            this.updateMiner(_loc3_,param1,_loc2_++);
         }
      }
      
      protected function rebalanceMiners(param1:StickWar) : void
      {
         var _loc5_:Miner = null;
         var _loc6_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         for each(_loc5_ in this.team.unitGroups[this.team.getMinerType()])
         {
            if(MinerAi(_loc5_.ai).targetOre is Statue)
            {
               _loc3_.push(_loc5_);
            }
            else if(MinerAi(_loc5_.ai).targetOre != null)
            {
               _loc2_.push(_loc5_);
            }
         }
         _loc6_ = Math.floor((_loc3_.length + _loc2_.length) / 3);
         if(_loc3_.length + _loc2_.length > 0)
         {
            if(_loc3_.length < _loc6_)
            {
               _loc5_ = _loc2_[0];
               MinerAi(_loc5_.ai).targetOre.releaseMiningSpot(_loc5_);
               _loc5_.team.statue.getMiningSpot(_loc5_);
               MinerAi(_loc5_.ai).targetOre = _loc5_.team.statue;
            }
            else if(_loc3_.length > _loc6_)
            {
               _loc5_ = _loc3_[0];
               MinerAi(_loc5_.ai).targetOre.releaseMiningSpot(_loc5_);
               this.iterateOverFreeMines(_loc5_,param1);
            }
         }
      }
      
      protected function updateMiner(param1:Miner, param2:StickWar, param3:int) : void
      {
         var _loc4_:Unit = null;
         var _loc5_:UnitMove = null;
         if(MinerAi(param1.ai).targetOre == null || MinerAi(param1.ai).targetOre && !MinerAi(param1.ai).targetOre.hasMiningSpot(param1))
         {
            if((_loc4_ = MinerAi(param1.ai).getClosestTarget()) != null && param1.team.direction * _loc4_.px < param1.team.direction * (param1.px - param1.team.direction * 100))
            {
               (_loc5_ = new UnitMove()).moveType = UnitCommand.ATTACK_MOVE;
               _loc5_.units.push(param1.id);
               _loc5_.owner = this.team.id;
               _loc5_.arg0 = _loc4_.px;
               _loc5_.arg1 = _loc4_.py;
               _loc5_.execute(this.team.game);
            }
            else
            {
               this.iterateOverFreeMines(param1,param2);
            }
         }
      }
      
      protected function iterateOverFreeMines(param1:Miner, param2:StickWar) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Ore = null;
         var _loc3_:Boolean = false;
         if(this.team.direction == 1)
         {
            _loc4_ = 0;
            while(_loc4_ < param2.map.gold.length)
            {
               _loc5_ = param2.map.gold[_loc4_];
               if(this.getFreeMine(param1,param2,_loc5_))
               {
                  _loc3_ = true;
                  break;
               }
               _loc4_++;
            }
         }
         else
         {
            _loc4_ = int(param2.map.gold.length - 1);
            while(_loc4_ >= 0)
            {
               _loc5_ = param2.map.gold[_loc4_];
               if(this.getFreeMine(param1,param2,_loc5_))
               {
                  _loc3_ = true;
                  break;
               }
               _loc4_--;
            }
         }
         if(!_loc3_)
         {
            MinerAi(param1.ai).targetOre = null;
         }
      }
      
      protected function getFreeMine(param1:Miner, param2:StickWar, param3:Ore) : Boolean
      {
         if(!param3.isMineFull())
         {
            param3.getMiningSpot(param1);
            MinerAi(param1.ai).targetOre = param3;
            return true;
         }
         return false;
      }
      
      protected function attackMoveGroupTo(param1:Number) : void
      {
         var _loc4_:String = null;
         var _loc5_:Unit = null;
         var _loc6_:UnitMove = null;
         this.isAttacking = true;
         var _loc2_:* = new UnitMove();
         _loc2_.moveType = UnitCommand.ATTACK_MOVE;
         var _loc3_:* = new UnitMove();
         _loc3_.moveType = UnitCommand.MOVE;
         for(_loc4_ in this.team.units)
         {
            if((_loc5_ = this.team.units[_loc4_]).isMiner() && MinerAi(_loc5_.ai).targetOre != null)
            {
               (_loc6_ = new UnitMove()).moveType = UnitCommand.MOVE;
               _loc6_.units.push(_loc5_.id);
               _loc6_.owner = this.team.id;
               _loc6_.arg4 = MinerAi(_loc5_.ai).targetOre.id;
               _loc6_.arg0 = MinerAi(_loc5_.ai).targetOre.x;
               _loc6_.arg1 = MinerAi(_loc5_.ai).targetOre.y;
               _loc6_.execute(this.team.game);
            }
            else if(_loc5_.isRejoiningFormation && this.team.direction * param1 <= this.team.direction * _loc5_.px)
            {
               _loc3_.units.push(_loc5_.id);
               if(Math.abs(_loc5_.px - param1) < 50)
               {
                  _loc5_.isRejoiningFormation = false;
               }
            }
            else
            {
               _loc2_.units.push(_loc5_.id);
               if(Math.abs(_loc5_.px - param1) > 1000)
               {
                  _loc5_.isRejoiningFormation = true;
               }
            }
         }
         _loc2_.owner = this.team.id;
         _loc2_.arg0 = param1;
         _loc2_.arg1 = this.team.game.gameScreen.game.map.height / 2;
         _loc2_.execute(this.team.game);
         _loc3_.owner = this.team.id;
         _loc3_.arg0 = param1;
         _loc3_.arg1 = this.team.game.gameScreen.game.map.height / 2;
         _loc3_.execute(this.team.game);
      }
      
      protected function garrisonGroup() : void
      {
         var _loc2_:String = null;
         this.isAttacking = false;
         var _loc1_:UnitMove = new UnitMove();
         _loc1_.moveType = UnitCommand.GARRISON;
         for(_loc2_ in this.team.units)
         {
            _loc1_.units.push(this.team.units[_loc2_].id);
         }
         _loc1_.owner = this.team.id;
         _loc1_.arg0 = 0;
         _loc1_.arg1 = this.team.game.map.height / 2;
         _loc1_.execute(this.team.game);
      }
      
      protected function defendGroup() : void
      {
         var _loc3_:String = null;
         var _loc4_:Unit = null;
         var _loc5_:UnitMove = null;
         this.isAttacking = false;
         var _loc1_:* = new UnitMove();
         _loc1_.moveType = UnitCommand.ATTACK_MOVE;
         var _loc2_:* = new UnitMove();
         _loc2_.moveType = UnitCommand.MOVE;
         for(_loc3_ in this.team.units)
         {
            if((_loc4_ = this.team.units[_loc3_]).isMiner() && MinerAi(_loc4_.ai).targetOre != null)
            {
               (_loc5_ = new UnitMove()).moveType = UnitCommand.MOVE;
               _loc5_.units.push(_loc4_.id);
               _loc5_.owner = this.team.id;
               _loc5_.arg0 = MinerAi(_loc4_.ai).targetOre.x;
               _loc5_.arg1 = MinerAi(_loc4_.ai).targetOre.y;
               _loc5_.arg4 = MinerAi(_loc4_.ai).targetOre.id;
               _loc5_.execute(this.team.game);
            }
            else if(!_loc4_.isHome)
            {
               _loc2_.units.push(_loc4_.id);
            }
            else
            {
               _loc1_.units.push(_loc4_.id);
            }
         }
         _loc2_.owner = this.team.id;
         _loc2_.arg0 = this.team.homeX + this.team.direction * 600;
         _loc2_.arg1 = this.team.game.gameScreen.game.map.height / 2;
         _loc1_.owner = this.team.id;
         _loc1_.arg0 = this.team.homeX + this.team.direction * 600;
         _loc1_.arg1 = this.team.game.gameScreen.game.map.height / 2;
         _loc1_.execute(this.team.game);
         _loc2_.execute(this.team.game);
      }
      
      protected function updateGlobalStrategy(param1:StickWar) : void
      {
         var _loc2_:Number = NaN;
         if(this.isArmyHealers())
         {
            this.defendGroup();
         }
         else if(this.enemyIsWeak())
         {
            this.attackMoveGroupTo(this.team.medianPosition + this.team.direction * 250);
         }
         else if(Boolean(this.enemyIsEvenStrength()) || Unit.U_GIANT in this.team.unitGroups)
         {
            _loc2_ = this.team.medianPosition + this.team.direction * 250;
            if(this.team.direction * _loc2_ > this.team.direction * this.team.game.map.width / 2)
            {
               _loc2_ = this.team.game.map.width / 2;
            }
            this.attackMoveGroupTo(_loc2_);
         }
         else if(this.enemyIsAttacking())
         {
            this.defendGroup();
         }
         else if(this.enemyAtMiddle())
         {
            this.defendGroup();
         }
         else
         {
            this.attackMoveGroupTo(this.team.game.map.width / 2);
         }
      }
      
      protected function updateUnitCreation(param1:StickWar) : void
      {
      }
      
      protected function updateSpellCasters(param1:StickWar) : void
      {
      }
      
      protected function isArmyHealers() : Boolean
      {
         return false;
      }
      
      protected function enemyIsWeak() : Boolean
      {
         var _loc1_:int = this.team.enemyTeam.castleDefence.units.length * 4 + this.team.enemyTeam.attackingForcePopulation;
         return _loc1_ < this.team.attackingForcePopulation;
      }
      
      protected function enemyIsEvenStrength() : Boolean
      {
         if(this.team.population == 0)
         {
            return false;
         }
         return Math.abs(this.team.enemyTeam.attackingForcePopulation - this.team.attackingForcePopulation) / this.team.attackingForcePopulation < 0.1;
      }
      
      protected function agressionMetric() : Number
      {
         var _loc1_:Number = this.team.enemyTeam.medianPosition / this.team.game.map.width;
         if(this.team.direction == 1)
         {
            _loc1_ = (this.team.game.map.width - this.team.enemyTeam.medianPosition) / this.team.game.map.width;
         }
         return _loc1_;
      }
      
      protected function enemyAtHome() : Boolean
      {
         return this.agressionMetric() < 0.4;
      }
      
      protected function enemyAtMiddle() : Boolean
      {
         return this.agressionMetric() > 0.4 && this.agressionMetric() < 0.6;
      }
      
      protected function enemyIsAttacking() : Boolean
      {
         return this.agressionMetric() >= 0.6;
      }
   }
}
