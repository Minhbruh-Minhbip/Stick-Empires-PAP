package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="featuredGameCard")]
   public dynamic class featuredGameCard extends MovieClip
   {
       
      
      public var type:TextField;
      
      public var usernameA:TextField;
      
      public var raceA:MovieClip;
      
      public var raceB:MovieClip;
      
      public var usernameB:TextField;
      
      public function featuredGameCard()
      {
         super();
      }
   }
}
