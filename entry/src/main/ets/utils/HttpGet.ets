/**
 * 网络请求工具类
 */
import http from '@ohos.net.http';
import hilog from '@ohos.hilog';
import { WanAndroidBean } from '../bean/WanAndroidBean';

export class HttpGet {

  //正确返回
  async doGet4() {
    let httpRequest = http.createHttp();
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });
    let result = await httpRequest.request(
      "https://www.wanandroid.com/article/list/1/json",
      {
        method: http.RequestMethod.GET,
      })
    return result;
  }


  async doGet5() {
    let model: WanAndroidBean
    let httpRequest = http.createHttp();
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });
    await httpRequest.request(
      "https://www.wanandroid.com/article/list/1/json",
    ).then((data) => {
      if (data.responseCode === http.ResponseCode.OK) {
        console.log(`----------------------success = ` + data.result.toString())
        model = JSON.parse(data.result.toString())
      }
    }).catch((err) => {
      console.log("--------------------failed")
      hilog.info(0x0000, 'testTag', 'error: ' + JSON.stringify(err))
      httpRequest.destroy()
    });
    return model;
  }
}