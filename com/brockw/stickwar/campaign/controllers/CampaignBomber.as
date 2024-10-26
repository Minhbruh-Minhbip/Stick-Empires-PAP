package com.brockw.stickwar.campaign.controllers
{
   import com.brockw.stickwar.GameScreen;
   import com.brockw.stickwar.engine.Ai.command.*;
   import com.brockw.stickwar.engine.Team.*;
   import com.brockw.stickwar.engine.units.*;
   
   public class CampaignBomber extends CampaignController
   {
      
      private static const MIN_NUM_BOMBERS:int = 2;
      
      public static const MAX_NUM_BOMBERS:int = 10;
      
      private static const FREQUENCY_SPAWN:int = 45;
      
      private static const FREQUENCY_INCREASE:int = 60;
       
      
      private var numToSpawn:int = 0;
      
      public function CampaignBomber(param1:GameScreen)
      {
         super(param1);
         this.numToSpawn = MIN_NUM_BOMBERS;
      }
      
      override public function update(param1:GameScreen) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Unit = null;
         if(param1.game.frame % (30 * FREQUENCY_SPAWN) == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.numToSpawn)
            {
               _loc3_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
               param1.team.enemyTeam.spawn(_loc3_,param1.game);
               _loc3_.px = param1.team.enemyTeam.statue.x;
               _loc3_.py = param1.game.map.height / 2;
               _loc3_.ai.setCommand(param1.game,new HoldCommand(param1.game));
               param1.team.enemyTeam.population += 1;
               _loc2_++;
            }
         }
         param1.game.team.enemyTeam.tech.isResearchedMap[Tech.GIANT_GROWTH_I] = true;
         param1.game.team.enemyTeam.tech.isResearchedMap[Tech.GIANT_GROWTH_II] = true;
         if(param1.game.frame % (30 * FREQUENCY_INCREASE) == 0)
         {
            ++this.numToSpawn;
            if(this.numToSpawn > MAX_NUM_BOMBERS)
            {
               this.numToSpawn = MAX_NUM_BOMBERS;
            }
         }
         param1.game.team.enemyTeam.attack(true);
      }
   }
}
