package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="clanEntryMc")]
   public dynamic class clanEntryMc extends MovieClip
   {
       
      
      public var members:TextField;
      
      public var nameText:TextField;
      
      public var view:SimpleButton;
      
      public var rankText:TextField;
      
      public function clanEntryMc()
      {
         super();
      }
   }
}
