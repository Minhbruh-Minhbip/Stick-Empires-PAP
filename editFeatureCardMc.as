package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="editFeatureCardMc")]
   public dynamic class editFeatureCardMc extends MovieClip
   {
       
      
      public var armor:TextField;
      
      public var description:TextField;
      
      public var misc:TextField;
      
      public var armorRadio:MovieClip;
      
      public var closeButton:SimpleButton;
      
      public var title:TextField;
      
      public var weaponRadio:MovieClip;
      
      public var miscRadio:MovieClip;
      
      public var weapon:TextField;
      
      public var unitType:TextField;
      
      public var updateButton:SimpleButton;
      
      public function editFeatureCardMc()
      {
         super();
      }
   }
}
