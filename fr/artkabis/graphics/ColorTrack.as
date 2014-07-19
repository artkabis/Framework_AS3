package fr.artkabis.graphics {

    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;    
    import flash.media.Camera;
    import flash.media.Video;
    
    public class ColorTrack extends Sprite {
        
        private var camera:Camera;
        private var video:Video;

        private var srcbd:BitmapData;
        private var viewbd:BitmapData;
        private var greenbd:BitmapData;
        private var bluebd:BitmapData;        
        
        private var mt:Matrix;
        private var mirrorMt:Matrix;
        private var pt:Point;
        private var rect:Rectangle;
        private var ct:ColorTransform;        

        
        public function ColorTrack() {
            init();
        }

        
        private function init():void {

            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            camera = Camera.getCamera();
            
            if (camera != null) {
                setupCamera();
            } else {
                trace("not camera");
                return;
            }
       
            srcbd = new BitmapData(camera.width*2, camera.height*2 ,false,0xffffff);
            viewbd = new BitmapData(camera.width*2, camera.height*2);
            greenbd = new BitmapData(camera.width*2, camera.height*2);
            bluebd = new BitmapData(camera.width*2, camera.height*2);
            
            mirrorMt = new Matrix();
            mirrorMt.scale(-1, 1);
            mirrorMt.translate(camera.width*2,0);            

            pt = new Point(0,0);
            rect = new Rectangle(0,0,camera.width*2, camera.height*2);
            ct = new ColorTransform();
            mt = new Matrix();

            addChild(new Bitmap(srcbd));
            var v:DisplayObject = addChild(new Bitmap(viewbd));
            v.x = camera.width*2 + 10;
            
            addEventListener(Event.ENTER_FRAME, loop);

        }


        private function setupCamera():void {
            
            video = new Video(camera.width*2, camera.height*2);
            video.attachCamera(camera);
            
        }


        private function loop(e:Event):void {

            srcbd.lock();
            viewbd.lock();
            greenbd.lock();
            bluebd.lock();
            
            srcbd.draw(video,mirrorMt);
            viewbd.draw(video,mirrorMt);
            greenbd.copyChannel(srcbd, rect, pt, BitmapDataChannel.GREEN, BitmapDataChannel.RED);
            bluebd.copyChannel(srcbd, rect, pt, BitmapDataChannel.BLUE, BitmapDataChannel.RED);
            bluebd.draw(greenbd, mt, ct, BlendMode.LIGHTEN);
            viewbd.draw(bluebd, mt,ct, BlendMode.SUBTRACT);
            
            viewbd.threshold(viewbd, rect, pt, ">", 0xff600000, 0xffffffff);
            viewbd.threshold(viewbd, rect, pt, "!=", 0xffffffff, 0xff000000);

            srcbd.unlock();
            viewbd.unlock();
            greenbd.unlock();
            bluebd.unlock();

        }        
    }
}
