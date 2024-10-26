package com.brockw.stickwar.engine.Team
{
   import com.brockw.stickwar.engine.StickWar;
   import flash.display.*;
   import flash.events.*;
   
   public class Hud extends MovieClip
   {
       
      
      public var hud:MovieClip;
      
      private var red:Number;
      
      private var green:Number;
      
      private var blue:Number;
      
      public function Hud(param1:MovieClip)
      {
         super();
         this.hud = param1;
         addChild(this.hud);
         this.hud.tabChildren = false;
         this.hud.tabEnabled = false;
         this.hud.garrisonButton.tabEnabled = false;
         this.hud.defendButton.tabEnabled = false;
         this.hud.attackButton.tabEnabled = false;
         blue = green = 0;
         red = 255;
      }
      
      public function mapClear() : void
      {
         MovieClip(this.hud.map).graphics.clear();
      }
      
      public function mapDrawFocus(param1:StickWar) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:Number = Number(MovieClip(this.hud.map).width);
         var _loc3_:Number = Number(MovieClip(this.hud.map).height);
         for(_loc6_ in param1.units)
         {
            if(param1.units[_loc6_].onMap(param1))
            {
               param1.units[_loc6_].drawOnHud(this.hud.map,param1);
            }
         }
         MovieClip(this.hud.map).graphics.lineStyle(0.5,0,1);
         MovieClip(this.hud.map).graphics.drawRect(_loc2_ * param1.screenX / param1.map.width,0,_loc2_ * param1.map.screenWidth / param1.map.width,_loc3_);
         if(param1.fogOfWar.isFogOn)
         {
            _loc7_ = _loc2_ * param1.team.getVisionRange() / param1.map.width;
            _loc8_ = 0;
            if(param1.team == param1.teamA)
            {
               _loc8_ = _loc7_;
               _loc7_ = _loc2_ - _loc7_;
            }
            MovieClip(this.hud.map).graphics.beginFill(0,0.8);
            MovieClip(this.hud.map).graphics.drawRect(_loc8_,0,_loc7_,_loc3_);
         }
      }
      
      public function createRGB(r:Number, g:Number, b:Number) : Number
      {
         return ((r & 255) << 16) + ((g & 255) << 8) + (b & 255);
      }
      
      public function update(param1:StickWar, param2:Team) : void
      {
         this.mapClear();
         this.mapDrawFocus(param1);
         var _loc3_:int = Math.floor(param1.frame / 30);
         var _loc4_:int = Math.floor(_loc3_ / 60);
         _loc3_ %= 60;
         if(_loc4_ < 10)
         {
            this.hud.clockMinutes.text = "0 " + _loc4_;
         }
         else
         {
            this.hud.clockMinutes.text = Math.floor(_loc4_ / 10) + " " + _loc4_ % 10;
         }
         if(_loc3_ < 10)
         {
            this.hud.clockSeconds.text = "0 " + _loc3_;
         }
         else
         {
            this.hud.clockSeconds.text = Math.floor(_loc3_ / 10) + " " + _loc3_ % 10;
         }
         if(param1.isReplay == false)
         {
            this.hud.replayHud.visible = false;
            if(true)
            {
               this.hud.fps.text = "FPS: " + Math.floor(param1.gameScreen.simulation.getQuickFPS());
               this.hud.ping.text = "Ping: " + int(param1.gameScreen.simulation.ping);
               this.hud.turnSize.text = "Turn Size: " + param1.gameScreen.simulation.turnSize;
               this.hud.fps.visible = false;
               this.hud.ping.visible = true;
               if(red > 0 && green < 255 && blue == 0)
               {
                  green++;
                  red--;
               }
               if(green > 0 && blue < 255 && red == 0)
               {
                  green--;
                  blue++;
               }
               if(blue > 0 && red < 255 && green == 0)
               {
                  blue--;
                  red++;
               }
               this.hud.turnSize.visible = false;
               this.hud.ping.background = true;
               this.hud.ping.backgroundColor = 0;
               this.hud.ping.textColor = 16777215;
            }
            else
            {
               this.hud.fps.visible = false;
               this.hud.ping.visible = false;
               this.hud.turnSize.visible = false;
            }
            this.hud.economicDisplay.visible = true;
            this.hud.economicDisplay.population.text = "" + Math.floor(param2.population);
            this.hud.economicDisplay.gold.text = "" + Math.floor(param2.gold);
            this.hud.economicDisplay.mana.text = "" + Math.floor(param2.mana);
         }
         else
         {
            this.hud.replayHud.visible = true;
            this.hud.economicDisplay.visible = false;
            this.hud.fps.visible = false;
            this.hud.ping.visible = false;
            this.hud.turnSize.visible = false;
            this.hud.replayHud.economicDisplay.population.text = "" + Math.floor(param1.teamB.population);
            this.hud.replayHud.economicDisplay.gold.text = "" + Math.floor(param1.teamB.gold);
            this.hud.replayHud.economicDisplay.mana.text = "" + Math.floor(param1.teamB.mana);
            this.hud.replayHud.economicDisplay2.visible = true;
            this.hud.replayHud.economicDisplay2.population.text = "" + Math.floor(param1.teamA.population);
            this.hud.replayHud.economicDisplay2.gold.text = "" + Math.floor(param1.teamA.gold);
            this.hud.replayHud.economicDisplay2.mana.text = "" + Math.floor(param1.teamA.mana);
            this.hud.replayHud.player1Name.text.text = param1.teamB.realName;
            this.hud.replayHud.player2Name.text.text = param1.teamA.realName;
         }
      }
   }
}
