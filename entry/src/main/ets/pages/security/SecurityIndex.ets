import common from '@ohos.app.ability.common'
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl'
import bundleManager from '@ohos.bundle.bundleManager'
import userIAM_userAuth from '@ohos.userIAM.userAuth';
import { BusinessError } from '@kit.BasicServicesKit';
import { Want } from '@kit.AbilityKit';
import userAuth from '@ohos.userIAM.userAuth';


@Extend(Button) function btnKvStyle() {
  .width('100%')
  .height(60)
  .fontSize(30)
  .align(Alignment.Center)
  .backgroundColor('#02bd79')
  .fontColor('#FFFFFF')
}

@Entry
@Component
struct SecurityIndex {
  @State message: string = 'Hello World'

  build() {
    Column({ space: 10 }) {
      Button('获取日历权限')
        .btnKvStyle()
        .onClick(async (event: ClickEvent) => {
          checkPermissions()
        })

      Button('认证能力')
        .btnKvStyle()
        .onClick(async (event: ClickEvent) => {
          checkPermissions()
        })
    }.padding({ left: 20, right: 20, top: 20 })
    .width('100%')
    .height('100%')
  }
}

function isHasAuth() {
  // 查询认证能力是否支持
  try {
    userIAM_userAuth.getAvailableStatus(userIAM_userAuth.UserAuthType.FACE, userIAM_userAuth.AuthTrustLevel.ATL1);
    console.info("current auth trust level is supported");
  } catch (error) {
    console.info("current auth trust level is not supported, error = " + error);
  }
}

function executeAuthResult() {
  // 设置认证参数
  const authParam: userAuth.AuthParam = {
    challenge: new Uint8Array([49, 49, 49, 49, 49, 49]),
    authType: [userAuth.UserAuthType.PIN, userAuth.UserAuthType.FACE],
    authTrustLevel: userAuth.AuthTrustLevel.ATL3,
  };
  // 配置认证界面
  const widgetParam: userAuth.WidgetParam = {
    title: '请进行身份认证',
  };
  try {
    // 获取认证对象
    let userAuthInstance = userAuth.getUserAuthInstance(authParam, widgetParam);
    console.info('get userAuth instance success');
    // 订阅认证结果
    userAuthInstance.on('result', {
      onResult(result) {
        console.info(`userAuthInstance callback result: ${JSON.stringify(result)}`);
        // 可在认证结束或其他业务需要场景，取消订阅认证结果
        userAuthInstance.off('result');
      }
    });
    console.info('auth on success');
    userAuthInstance.start();
    console.info('auth start success');
  } catch (error) {
    const err: BusinessError = error as BusinessError;
    console.error(`auth catch error. Code is ${err?.code}, message is ${err?.message}`);
  }
}

function executeAuthResult2() {
  // 设置认证参数
  let reuseUnlockResult: userAuth.ReuseUnlockResult = {
    reuseMode: userAuth.ReuseMode.AUTH_TYPE_RELEVANT,
    reuseDuration: userAuth.MAX_ALLOWABLE_REUSE_DURATION,
  }
  const authParam: userAuth.AuthParam = {
    challenge: new Uint8Array([49, 49, 49, 49, 49, 49]),
    authType: [userAuth.UserAuthType.FACE],
    authTrustLevel: userAuth.AuthTrustLevel.ATL3,
    reuseUnlockResult: reuseUnlockResult,
  };
  // 配置认证界面
  const widgetParam: userAuth.WidgetParam = {
    title: '请进行身份认证',
  };
  try {
    // 获取认证对象
    let userAuthInstance = userAuth.getUserAuthInstance(authParam, widgetParam);
    console.info('get userAuth instance success');
    // 订阅认证结果
    userAuthInstance.on('result', {
      onResult(result) {
        console.info(`userAuthInstance callback result: ${JSON.stringify(result)}`);
        // 可在认证结束或其他业务需要场景，取消订阅认证结果
        userAuthInstance.off('result');
      }
    });
    console.info('auth on success');
    userAuthInstance.start();
    console.info('auth start success');
  } catch (error) {
    const err: BusinessError = error as BusinessError;
    console.error(`auth catch error. Code is ${err?.code}, message is ${err?.message}`);
  }
}

function cancelAuth() {
  const authParam: userAuth.AuthParam = {
    challenge: new Uint8Array([49, 49, 49, 49, 49, 49]),
    authType: [userAuth.UserAuthType.PIN, userAuth.UserAuthType.FACE],
    authTrustLevel: userAuth.AuthTrustLevel.ATL3,
  };
  const widgetParam: userAuth.WidgetParam = {
    title: '请进行身份认证',
  };
  try {
    // 获取认证对象
    let userAuthInstance = userAuth.getUserAuthInstance(authParam, widgetParam);
    console.log('get userAuth instance success');
    // 开始认证
    userAuthInstance.start();
    console.log('auth start success');
    // 取消认证
    userAuthInstance.cancel();
    console.log('auth cancel success');
  } catch (error) {
    const err: BusinessError = error as BusinessError;
    console.error(`auth catch error. Code is ${err?.code}, message is ${err?.message}`);
  }
}


async function checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
  let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
  let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;

  // 获取应用程序的accessTokenID
  let tokenId: number = 0;
  let bundleInfo: bundleManager.BundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
  console.info('Succeeded in getting Bundle.');
  let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
  tokenId = appInfo.accessTokenId;

  // 校验应用是否被授予权限
  grantStatus = await atManager.checkAccessToken(tokenId, permission);
  console.info('Succeeded in checking access token.');
  return grantStatus;
}

async function checkPermissions(): Promise<void> {
  const permissions: Array<Permissions> = ['ohos.permission.READ_CALENDAR'];
  let grantStatus: abilityAccessCtrl.GrantStatus = await checkAccessToken(permissions[0]);

  if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
    // 已经授权，可以继续访问目标操作
    console.log(`checkAccessToken ohos.permission.READ_CALENDAR IS OK`);
  } else {
    // 申请日历权限
    console.log(`checkAccessToken ohos.permission.READ_CALENDAR IS reqPermissionsFromUser`);
    reqPermissionsFromUser(permissions)
  }
}

function reqPermissionsFromUser(permissions: Array<Permissions>): void {
  let context = getContext() as common.UIAbilityContext;
  let atManager = abilityAccessCtrl.createAtManager();
  // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
  atManager.requestPermissionsFromUser(context, permissions).then((data) => {
    let grantStatus: Array<number> = data.authResults;
    let length: number = grantStatus.length;
    for (let i = 0; i < length; i++) {
      if (grantStatus[i] === 0) {
        // 用户授权，可以继续访问目标操作
        console.log(`checkAccessToken ohos.permission.READ_CALENDAR IS grantStatus, OK`);
      } else {
        // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
        console.log(`checkAccessToken ohos.permission.READ_CALENDAR IS Reject`);
        openPermissionsInSystemSettings()
        return;
      }
    }
    // 授权成功
  }).catch((err:BusinessError) => {
    console.error(`requestPermissionsFromUser failed, code is ${err.code}, message is ${err.message}`);
  })
}

function openPermissionsInSystemSettings(): void {
  let context = getContext() as common.UIAbilityContext;
  let wantInfo : Want = {
    action: 'action.settings.app.info',
    parameters: {
      settingsParamBundleName: 'com.example.myapplication' // 打开指定应用的详情页面
    }
  }
  context.startAbility(wantInfo).then(() => {
    console.log(`checkAccessToken ohos.permission.READ_CALENDAR IS startAbility then`);
  }).catch(() => {
    console.log(`checkAccessToken ohos.permission.READ_CALENDAR IS startAbility catch`);
  })
}