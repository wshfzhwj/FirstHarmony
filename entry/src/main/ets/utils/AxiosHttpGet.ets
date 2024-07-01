import  axios, { AxiosResponse } from '@ohos/axios';
import { WanAndroidBean } from '../bean/WanAndroidBean';
import { BusinessError } from '@kit.BasicServicesKit';

class AxiosHttpGet {
  baseUrl: string = 'https://www.wanandroid.com'
  pageNo: number = 0

  getAuthorList(): Promise<WanAndroidBean> {
    let url = `${this.baseUrl}/article/list/${this.pageNo}/json`
    console.log('------------AxiosHttpGet----------url = ' + url)
    return new Promise((resolve, reject) => {
      axios.get(url)
        .then((response:AxiosResponse) => {
          console.log('----------------------AxiosHttpGet then')
          if (response.status === 200 ) {
            console.log('----------------------AxiosHttpGet success ')
            resolve(response.data)
          } else {
            console.log('-------AxiosHttpGet------------AxiosHttpGet 查询失败')
            reject('查询失败')
          }
        })
        .catch((err:BusinessError) => {
          console.log('--------------------AxiosHttpGet catch', err)
          reject('查询失败')
        })
    })
  }
}

const axiosHttpGet = new AxiosHttpGet()

export default axiosHttpGet as AxiosHttpGet;