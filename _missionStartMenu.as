package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="_missionStartMenu")]
   public dynamic class _missionStartMenu extends MovieClip
   {
       
      
      public var startButton:SimpleButton;
      
      public var descriptionText:TextField;
      
      public var titleText:TextField;
      
      public var closeButton:MovieClip;
      
      public function _missionStartMenu()
      {
         super();
      }
   }
}
