import router from '@ohos.router'
import Person from '../../model/Person'

@Entry
@Component
struct PersistPropsOtherIndex {
  @StorageLink("user")
  userData: string = ""
  @State user: Person = JSON.parse(this.userData)

  build() {
    Column() {
      Text(this.user.name + "----" + this.user.age)
      Button("修改age").onClick(() => {
        this.user.age++
        AppStorage.Set<string>("user", JSON.stringify(this.user))
      })
      Button("返回Index页面").onClick(() => {
        router.back()
      })
    }
    .width("100%")
    .height("100%")
  }
}