package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="messageContainer")]
   public dynamic class messageContainer extends MovieClip
   {
       
      
      public var message:TextField;
      
      public function messageContainer()
      {
         super();
      }
   }
}
