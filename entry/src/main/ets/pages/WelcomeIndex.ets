import common from '@ohos.app.ability.common'
import UserPrivacyDialog from '../view/dialog/UserPrivacyDialog'
import PreferenceUtil from '../utils/PreferenceUtil'
import router from '@ohos.router';

const PREF_KEY = 'userPrivacyKey'

@Entry
@Component
struct WelcomePage {
  context = getContext(this) as common.UIAbilityContext
  controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({
      confirm: (): void => this.onConfirm(),
      cancel: (): void => this.exitApp()
    })
  })

  async aboutToAppear() {
    //加载首选项
    let isAgree = await PreferenceUtil.getPreferenceValue(PREF_KEY, false)
    //判断是否同意
    if (isAgree) {
      //同意跳首页
      this.jumpToIndex()
    } else {
      //弹窗
      this.controller.open()
    }
  }

  jumpToIndex() {
    setTimeout(() => {
      router.replaceUrl({
        url: 'pages/MainIndex'
      }, router.RouterMode.Standard, (err) => {
        if (err) {
          console.error(`Invoke replaceUrl failed, code is ${err.code}, message is ${err.message}`);
          return;
        }
        console.info('Invoke replaceUrl succeeded.');
      })
    }, 500)
  }

  onConfirm() {
    //保存首选项
    PreferenceUtil.putPreferenceValue(PREF_KEY, true)
    //跳转到首页
    this.jumpToIndex()
  }

  exitApp() {
    //退出APP
    this.context.terminateSelf()
  }

  build() {
    Column() {
      Text('这是一个欢迎页面')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#03b603')

  }
}