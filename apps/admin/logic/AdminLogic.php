<?php

namespace app\admin\logic;

use app\common\logic\Base as BaseLogic;

class AdminLogic extends BaseLogic {

    //依赖的应用对应的类型标识
    const DEPEND_APP_TYPE = ['module' => 1,'plugin' => 2,'theme'  => 3];

    //依赖的应用对应的类型
    const DEPEND_TYPE_APP = [1=>'module',2=>'plugin',3=>'theme'];

	protected function initialize()
    {
        parent::initialize();
        $this->currentUser = session('admin_login_auth');
        $this->uid = is_admin_login();
    }

    /**
     * 校验当前用户是否允许同时登录
     * @return [type] [description]
     * @date   2018-02-28
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public static function checkAllowLoginByTime()
    {
        if (config('admin_allow_login_many')==1) {
            return true;
        } elseif (session('admin_activation_auth_sign') == model('admin/AdminUser')->where('uid',is_admin_login())->value('activation_auth_sign')) {
            return true;
        }
        return false;
    }
}