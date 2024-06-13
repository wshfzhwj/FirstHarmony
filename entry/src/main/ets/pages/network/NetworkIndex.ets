import { WanAndroidBean } from '../../bean/WanAndroidBean';
import { HttpGet } from '../../utils/HttpGet';
import HeiMaHttp from '../../utils/HeiMaHttp';
import AxiosHttpGet from '../../utils/AxiosHttpGet';
import { WanBeanItem } from '../../bean/WanBeanItem';

@Entry
@Component
struct NetworkIndex {
  @State message: string = 'Hello World'
  @State wanBeanList: WanBeanItem[] = []
  isLoading: boolean = false;
  httpGet: HttpGet = new HttpGet();

  aboutToAppear() {
    this.loadNetData()
  }

  loadNetData() {
    // HeiMaHttp.getAuthorList().then(bean => {
    //   bean.data.datas.forEach((item: WanBeanItem) => {
    //     this.isLoading = false
    //     this.wanBeanList.push(item)
    //   })
    // })

    AxiosHttpGet.getAuthorList().then(bean => {
      bean.data.datas.forEach((item: WanBeanItem) => {
        this.isLoading = false
        this.wanBeanList.push(item)
      })
    })
    // this.httpGet.doGet5().then(data => {
    //   data.data.datas.forEach((item: WanBeanItem) => {
    //     this.wanBeanList.push(item)
    //   })
    // })
    // this.httpGet.doGet4().then(response => {
    //   let wanAndroidBean: WanAndroidBean = JSON.parse(response.result.toString())
    //   wanAndroidBean.data.datas.forEach((item: WanBeanItem) => {
    //     this.wanBeanList.push(item)
    //   })
    // })
  }

  build() {
    Column() {
      Text('WanAndroid文章').fontSize(30)
      List({ space: 5 }) {
        if (this.wanBeanList.length != 0) {
          ForEach(this.wanBeanList, (item: WanBeanItem, index: number) => {
            ListItem() {
              Column() {
                Text(`${index + 1}.${item.title}`)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .width('100%')
                  .maxLines(1)
                Text(`作者: ${item.author}`)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold).width('100%')
              }
              .backgroundColor('#0ccccc')
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .border({ width: 1 })
              .borderColor('#578')
            }
          })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .onReachEnd(() => {
        console.log('触底了',!this.isLoading);
        if (!this.isLoading) {
          this.isLoading = true
          console.log('加载数据');
          HeiMaHttp.pageNo++
          this.loadNetData()
        }

      })
    }.height('100%')

  }
}