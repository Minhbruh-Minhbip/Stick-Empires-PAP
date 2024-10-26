package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="loginBoxForFacebook")]
   public dynamic class loginBoxForFacebook extends MovieClip
   {
       
      
      public var errorText:TextField;
      
      public var alreadyHaveAccountButton:SimpleButton;
      
      public var indicator:MovieClip;
      
      public var createUsername:SimpleButton;
      
      public var usernameInput:TextField;
      
      public function loginBoxForFacebook()
      {
         super();
      }
   }
}
