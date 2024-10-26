package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="inGameMessagePromptMc")]
   public dynamic class inGameMessagePromptMc extends MovieClip
   {
       
      
      public var message:TextField;
      
      public function inGameMessagePromptMc()
      {
         super();
      }
   }
}
