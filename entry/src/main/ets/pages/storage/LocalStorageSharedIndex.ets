import router from '@ohos.router'
// 通过getShared接口获取stage共享的LocalStorage实例
let storage = LocalStorage.getShared()
@Entry(storage)
@Component
struct LocalStorageSharedIndex {
  @LocalStorageLink('cityName') cityName:string = ''

  build() {
    Row() {
      Column() {
        Text('Comp1'+'-'+this.cityName)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Button('去Comp1')
          .onClick(()=>{
            router.pushUrl({
              url:'pages/storage/LocalStorageSharedIndex2'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}