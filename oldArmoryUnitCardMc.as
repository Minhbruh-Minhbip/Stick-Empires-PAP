package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="oldArmoryUnitCardMc")]
   public dynamic class oldArmoryUnitCardMc extends MovieClip
   {
       
      
      public var background:Armory_Background;
      
      public var rightArrow:SimpleButton;
      
      public var leftArrow:SimpleButton;
      
      public var displayContainer:MovieClip;
      
      public var unitName:TextField;
      
      public function oldArmoryUnitCardMc()
      {
         super();
      }
   }
}
