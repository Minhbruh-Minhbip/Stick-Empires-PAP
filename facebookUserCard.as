package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="facebookUserCard")]
   public dynamic class facebookUserCard extends MovieClip
   {
       
      
      public var ratingText:TextField;
      
      public var container:MovieClip;
      
      public var connecting:MovieClip;
      
      public var usernameText:TextField;
      
      public function facebookUserCard()
      {
         super();
      }
   }
}
