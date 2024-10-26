package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="facebookLoginScreenMc")]
   public dynamic class facebookLoginScreenMc extends MovieClip
   {
       
      
      public var alreadyHaveAccoutCard:alreadyHaveAccountMc;
      
      public var connecting:MovieClip;
      
      public var createUsernameBox:loginBoxForFacebook;
      
      public function facebookLoginScreenMc()
      {
         super();
      }
   }
}
