package com.brockw.stickwar.campaign.controllers
{
   import com.brockw.stickwar.GameScreen;
   import com.brockw.stickwar.campaign.*;
   import com.brockw.stickwar.engine.units.*;
   
   public class CampaignArcher extends CampaignController
   {
       
      
      private var message:InGameMessage;
      
      private var frames:int;
      
      private var arrow:tutorialArrow;
      
      internal var state:int = 0;
      
      internal var S_BEFORE:int = 0;
      
      internal var S_SELECT:int = 1;
      
      internal var S_HILL:int = 2;
      
      internal var S_DONE:int = 2;
      
      public function CampaignArcher(param1:GameScreen)
      {
         super(param1);
         this.frames = 0;
         this.state = this.S_BEFORE;
      }
      
      override public function update(param1:GameScreen) : void
      {
         if(this.arrow != null)
         {
            if(this.arrow.currentFrame == this.arrow.totalFrames)
            {
               this.arrow.gotoAndPlay(1);
            }
            else
            {
               this.arrow.nextFrame();
            }
         }
         if(this.message)
         {
            this.message.update();
         }
         if(this.state == this.S_BEFORE)
         {
            if(param1.game.frame > 30 && param1.userInterface.selectedUnits.interactsWith & Unit.I_ENEMY && !(param1.userInterface.selectedUnits.interactsWith & Unit.I_MINE))
            {
               this.state = this.S_SELECT;
               this.message = new InGameMessage("",param1.game);
               this.message.x = param1.game.stage.stageWidth / 2 + 205;
               this.message.y = param1.game.stage.stageHeight - 190;
               this.message.scaleX *= 0.9;
               this.message.scaleY *= 0.9;
               this.message.visible = false;
               this.message.setMessage("Gain full control over individual units by clicking commands such as hold position.","");
               param1.addChild(this.message);
               this.frames = 0;
               this.arrow = new tutorialArrow();
               param1.addChild(this.arrow);
               this.arrow.x = param1.game.stage.stageWidth / 2 + 392;
               this.arrow.y = param1.game.stage.stageHeight - 35;
            }
         }
         else if(this.state == this.S_SELECT)
         {
            if(param1.userInterface.selectedUnits.interactsWith & Unit.I_ENEMY)
            {
               this.arrow.visible = true;
            }
            else
            {
               this.arrow.visible = false;
            }
            if(this.message.isShowingNewMessage())
            {
               this.message.visible = true;
            }
            if(this.frames++ > 30 * 10)
            {
               this.message.visible = false;
               this.arrow.visible = false;
            }
            if(Boolean(param1.team.forwardUnit) && param1.team.forwardUnit.x > param1.game.map.width / 2)
            {
               this.message.x = param1.game.stage.stageWidth / 2;
               this.message.y = param1.game.stage.stageHeight / 4 - 75;
               this.message.scaleX = 1.3;
               this.message.scaleY = 1.3;
               this.message.setMessage("Capturing the center tower will award you a continuous stream of gold for as long as you hold the tower","");
               this.frames = 0;
               this.state = this.S_HILL;
            }
         }
         else if(this.state == this.S_HILL)
         {
            if(this.frames++ < 3 * 30)
            {
               param1.game.targetScreenX = param1.game.map.hills[0].x - param1.game.map.screenWidth / 2;
            }
            if(this.message.isShowingNewMessage())
            {
               this.message.visible = true;
            }
            if(this.frames++ > 7.5 * 30)
            {
               this.state = this.S_DONE;
               this.message.visible = false;
               this.arrow.visible = false;
            }
         }
         else if(this.state == this.S_DONE)
         {
         }
      }
   }
}
