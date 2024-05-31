/**
 * 网络请求工具类
 */
import http from '@ohos.net.http';
import { WanAndroidBean } from '../bean/WanAndroidBean';

class HeiMaHttp {
  baseUrl: string = 'https://www.wanandroid.com'
  pageNo: number = 0

  getAuthorList(): Promise<WanAndroidBean> {
    console.log(`-----------HeiMaHttp getAuthorList----------- `)
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.on('headersReceive', (header) => {
        console.info('header: ' + JSON.stringify(header));
      });
      let url = `${this.baseUrl}/article/list/${this.pageNo}/json`
      console.log('------------HeiMaHttp----------url = '+ url)
      httpRequest.request(url, { method: http.RequestMethod.GET })
        .then((data) => {
          if (data.responseCode === http.ResponseCode.OK) {
            console.log('----------------------HeiMaHttp success ', JSON.parse(data.result.toString()),this.pageNo)
            resolve(JSON.parse(data.result.toString()))
          } else {
            console.log('-------HeiMaHttp------------HeiMaHttp 查询失败', JSON.stringify(data))
            reject('查询失败')
          }
        })
        .catch((err) => {
          console.log('--------------------HeiMaHttp catch', JSON.stringify(err))
          reject('查询失败')
        });
    })
  }
}

const heiMaHttp = new HeiMaHttp()

export default heiMaHttp as HeiMaHttp;