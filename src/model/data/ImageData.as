package model.data {
import flash.display.Bitmap;
import flash.display.BitmapData;

public class ImageData {
    private var _id:String;
    private var _path:String;
    private var _bitmapData:BitmapData;
    public function ImageData() {
    }
    public function setXml(xml:XML):void
    {
        _id = xml.@["id"];
        _path = xml;
    }
    public  function setBitmapData(bitmapData:BitmapData):void
    {
        _bitmapData = bitmapData;
    }


    public function get id():String {
        return _id;
    }

    public function get path():String {
        return _path;
    }

    public function get bitmapData():BitmapData {
        return _bitmapData;
    }
}
}
