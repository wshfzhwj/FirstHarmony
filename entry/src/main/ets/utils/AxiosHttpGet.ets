import  axios from '@ohos/axios';
import { WanAndroidBean } from '../bean/WanAndroidBean';

class AxiosHttpGet {
  baseUrl: string = 'https://www.wanandroid.com'
  pageNo: number = 0

  getAuthorList(): Promise<WanAndroidBean> {
    let url = `${this.baseUrl}/article/list/${this.pageNo}/json`
    console.log('------------AxiosHttpGet----------url = ' + url)
    return new Promise((resolve, reject) => {
      axios.get(url)
        .then(response => {
          console.log('----------------------AxiosHttpGet then')
          if (response.status === 200 ) {
            console.log('----------------------AxiosHttpGet success ')
            resolve(response.data)
          } else {
            console.log('-------AxiosHttpGet------------AxiosHttpGet 查询失败')
            reject('查询失败')
          }
        })
        .catch(error => {
          console.log('--------------------AxiosHttpGet catch', error)
          reject('查询失败')
        })
    })
  }
}

const axiosHttpGet = new AxiosHttpGet()

export default axiosHttpGet as AxiosHttpGet;