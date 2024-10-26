package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="returningRewardMc")]
   public dynamic class returningRewardMc extends MovieClip
   {
       
      
      public var members:TextField;
      
      public var acceptButton:SimpleButton;
      
      public var message:TextField;
      
      public var bonusPopup:bonusPopUp;
      
      public var days:TextField;
      
      public function returningRewardMc()
      {
         super();
      }
   }
}
