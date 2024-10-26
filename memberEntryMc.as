package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="memberEntryMc")]
   public dynamic class memberEntryMc extends MovieClip
   {
       
      
      public var visitProfile:SimpleButton;
      
      public var ratingText:TextField;
      
      public var kickButton:SimpleButton;
      
      public var viewRequest:SimpleButton;
      
      public var nameText:TextField;
      
      public var winText:TextField;
      
      public function memberEntryMc()
      {
         super();
      }
   }
}
