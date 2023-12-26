import { HttpGet } from "../utils/HttpGet"
import { WanAndroidBean } from '../bean/WanAndroidBean'
import { WanListBean } from '../bean/WanListBean'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State wanAndroidBean: WanAndroidBean = null;
  @State msg: string = '';
  httpGet: HttpGet = new HttpGet();

  build() {
    Column() {
      // Button('请求')
      //   .onClick(() => {
      //     this.httpGet.doGet5().then(data => {
      //       this.wanAndroidBean = data
      //     })
      //   });
      // Text("ssss")
      //正确返回
      Button('请求')
        .fontColor(Color.White)
        .onClick(() => {
          this.httpGet.doGet4().then(response => {
            this.wanAndroidBean = JSON.parse(response.result.toString())
            console.log("-----------dsb------" + this.wanAndroidBean.data.datas.length);
          })
        })
      if (this.wanAndroidBean != null) {
        // Text(`下边是：2 ${this.wanAndroidBean.errorCode}`)
        ForEach(
          this.wanAndroidBean.data.datas,
          (item: WanListBean, index: number) => {
            Text(`下边是：${item.author}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
          })
      }
    }
  }
}