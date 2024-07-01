import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import distributedKVStore from '@ohos.data.distributedKVStore';
import { CommonConstants } from '../constants/CommonConstants';
import DateUtil from '../utils/DateUtil';
import DbUtil from '../utils/DbUtil';
import PreferenceUtil from '../utils/PreferenceUtil'
import RecordModel from '../viewmodel/RecordViewModel';
import { AbilityConstant, Want } from '@kit.AbilityKit';


export default class EntryAbility extends UIAbility {
  // storage:LocalStorage = new LocalStorage({cityName:'北京'})

  async onCreate(want:Want, launchParam: AbilityConstant.LaunchParam) {
    //初始化share
    PreferenceUtil.loadPreference(this.context)
    AppStorage.setOrCreate(CommonConstants.RECORD_DATE,DateUtil.beginTimeOfDay(new Date()))
    //初始化数据库
    await DbUtil.initDB(this.context)
    DbUtil.createTable(RecordModel.getCreateTableSql())
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    // 设置WindowStage的事件订阅（获焦/失焦、可见/不可见）
    // try {
    //   windowStage.on('windowStageEvent', (data) => {
    //     let stageEventType: window.WindowStageEventType = data;
    //     switch (stageEventType) {
    //       case window.WindowStageEventType.SHOWN: // 切到前台
    //         console.info('windowStage foreground.');
    //         break;
    //       case window.WindowStageEventType.ACTIVE: // 获焦状态
    //         console.info('windowStage active.');
    //         break;
    //       case window.WindowStageEventType.INACTIVE: // 失焦状态
    //         console.info('windowStage inactive.');
    //         break;
    //       case window.WindowStageEventType.HIDDEN: // 切到后台
    //         console.info('windowStage background.');
    //         break;
    //       default:
    //         break;
    //     }
    //   });
    // } catch (exception) {
    //   console.error('Failed to enable the listener for window stage event changes. Cause:' + JSON.stringify(exception));
    // }
    windowStage.loadContent('pages/WelcomeIndex', (err, data) => {
    // windowStage.loadContent('pages/demo/ComponentA', (err, data) => {
    // windowStage.loadContent('pages/MainIndex', (err, data) => {
    // windowStage.loadContent('pages/storage/LocalStorageSharedIndex',this.storage, (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
