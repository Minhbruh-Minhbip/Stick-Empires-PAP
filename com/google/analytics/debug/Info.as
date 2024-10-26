package com.google.analytics.debug
{
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class Info extends Label
   {
       
      
      private var _timer:Timer;
      
      public function Info(param1:String = "", param2:uint = 3000)
      {
         super(param1,"uiInfo",Style.infoColor,Align.top,true);
         if(param2 > 0)
         {
            _timer = new Timer(param2,1);
            _timer.start();
            _timer.addEventListener(TimerEvent.TIMER_COMPLETE,onComplete,false,0,true);
         }
      }
      
      public function onComplete(param1:TimerEvent) : void
      {
         close();
      }
      
      override public function onLink(param1:TextEvent) : void
      {
         switch(param1.text)
         {
            case "hide":
               close();
         }
      }
      
      public function close() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}