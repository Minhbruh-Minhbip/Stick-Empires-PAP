package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="itemUnlockResultMc")]
   public dynamic class itemUnlockResultMc extends MovieClip
   {
       
      
      public var description:TextField;
      
      public var resultText:TextField;
      
      public var doneButton:SimpleButton;
      
      public function itemUnlockResultMc()
      {
         super();
      }
   }
}
