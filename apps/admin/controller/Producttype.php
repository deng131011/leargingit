<?php
// 授权管理控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 https://www.eacoophp.com, All rights reserved.         
// +----------------------------------------------------------------------
// | [EacooPHP] 并不是自由软件,可免费使用,未经许可不能去掉EacooPHP相关版权。
// | 禁止在EacooPHP整体或任何部分基础上发展任何派生、修改或第三方版本用于重新分发
// +----------------------------------------------------------------------
// | Author:  心云间、凝听 <981248356@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\controller;

use app\admin\model\AuthRule as AuthRuleModel;
use app\admin\model\AuthGroup as AuthGroupModel;
use app\admin\model\AuthGroupAccess as AuthGroupAccessModel;

class Producttype extends Admin {

    function _initialize()
    {
        parent::_initialize();
        $this->Producttype = model('Producttype');
        $this->position_type = ['2'=>'关闭','1'=>'开启'];
    }

    /**
     * 后台菜单管理
     * @return [type] [description]
     */
    public function index(){

        //移动上级按钮属性
        $move_position_attr = [
            'title'   => '移动位置',
            'icon'    => 'fa fa-exchange',
            'class'   => 'btn btn-info btn-sm',
            'onclick' => 'move_menuposition()'
        ];

        $map['status'] = array('gt',-1);
        $menus = logic('Typetree')->getAdminMenu('producttype',$map);
        $extra_html = logic('Auth')->moveMenuHtml();//添加移动按钮html
        $content = builder('List')
            ->addTopBtn('addnew')  // 添加新增按钮
            ->addTopBtn('resume',['model'=>'auth_rule'])  // 添加启用按钮
            ->addTopBtn('forbid',['model'=>'auth_rule'])  // 添加禁用按钮
            ->addTopBtn('delete',['model'=>'auth_rule'])  // 添加删除按钮
            ->addTopButton('self', $move_position_attr) //移动菜单位置
            ->setSearch('请输入关键字')
            ->keyListItem('id','ID编号')
            ->keyListItem('sort', '排序')
            ->keyListItem('title','名称')
            ->keyListItem('is_tjposition','推荐位','array',$this->position_type)
            ->keyListItem('status','状态','status')
            ->keyListItem('right_button', '操作', 'btn')
            ->setListData($menus)     // 数据列表
            ->setExtraHtml($extra_html)
            ->addRightButton('edit')     // 添加编辑按钮
            ->addRightButton('delete')  // 添加删除按钮
            ->addRightButton('forbid') // 添加禁用按钮
            ->fetch();

        return Iframe()
            ->setMetaTitle('广告位置')  // 设置页面标题
            ->content($content);
    }


    /**
     * 菜单编辑
     * @param  integer $id [description]
     * @return [type]      [description]
     */
    public function edit($id=0){
        $title = $id ? "编辑":"新增";
        
        if(IS_POST){
            // 提交数据
            $data = $this->request->param();
            //验证数据
            $checkres = $this->Producttype->checkForm($data,'AuthRule.edit');
            if($checkres['code']==201){
                $this->error($checkres['msg']);
            }
            if($data['pid']==$data['id']){
                $this->error('上级菜单不能选择本级');
            }

            //$data里包含主键id，则editData就会更新数据，否则是新增数据
            if ($this->Producttype->editData($data)) {
                $this->success($title.'菜单成功', url('index',['pid'=>input('param.pid')]));
            } else {
                $this->error($this->authRuleModel->getError());
            }   

        } else{

            // 获取表单数据
            $info = array();
            $info =db('producttype')->where('id',$id)->find();

            //获取上级菜单
            $map['status'] = array('gt',-1);
            $menus = logic('Typetree')->getAdminMenu('producttype',$map);
            $menus = !empty($menus) ? $menus : array();
            $menus = array_merge([0=>['id'=>0,'title_show'=>'顶级菜单']], $menus);
            $extra_html = logic('Auth')->getFormMenuHtml();//获取表单菜单html

            $tab_list = [
                ['title'=>'基本信息','href'=>''],
                ['title'=>'内容','href'=>''],
            ];

            $content = builder('form')
                    ->SetTabNav($tab_list,0)  // 设置Tab按钮列表
                    ->addFormItem('id', 'hidden', 'ID', 'ID')
                    ->addFormItem('title', 'text', '分类标题', '必须填写')
                    ->addFormItem('pid', 'multilayer_select', '上级菜单', '上级菜单',$menus)
                    ->addFormItem('sort', 'number', '排序', '按照数值大小的升序进行排序，数值越小越靠前')
                    ->addFormItem('is_tjposition', 'radio', '推荐位', '勾选开启则自动生成推荐位',[1=>'开启',2=>'关闭'])
                    ->addFormItem('status', 'radio', '状态', '',[1=>'启用',0=>'禁用'])
                    ->addFormItem('icon', 'picture', '分类图标', '')
                    ->addFormItem('content', 'ueditor', '分类内容', '选填')
                    ->setFormData($info)
                    ->setExtraHtml($extra_html)
                    ->addButton('submit')->addButton('back')    // 设置表单按钮
                    ->fetch();
                    
            return Iframe()
                    ->setMetaTitle($title.'商品分类')  // 设置页面标题
                    ->content($content);
        }   
        
    }

    /**
     * 获取依赖标识组
     * @param  integer $depend_type 依赖类型
     * @return [type] [description]
     * @date   2018-02-20
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function getSelectDependFlags($depend_type=0)
    {
        $data_list = logic('Auth')->getDependFlags($depend_type);
        return json($data_list);
    }

    /**
     * 对菜单进行排序
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function Sort($ids = null)
    {
        $builder = builder('Sort');
        $depend_flag = input('param.depend_flag','all');//是否存在父ID
        $map     = [];
        if ($depend_flag!='all' && $depend_flag) {
            $map['depend_flag']=$depend_flag;
        }
        
        if (IS_POST) {
            cache('admin_sidebar_menus_'.$this->currentUser['uid'],null);//清空后台菜单缓存
            $builder->doSort('auth_rule', $ids);
        } else {
            $map['status'] = 1;
            $list = $this->authRuleModel->getList($map,'id,title,sort,pid','sort asc,id asc');
            foreach ($list as $key => $val) {
                $list[$key]['title'] = $val['title'];
            }

            $content = $builder
                    ->setListData($list)
                    ->addButton('submit')->addButton('back')
                    ->fetch();

            return Iframe()
                    ->setMetaTitle('菜单排序')  // 设置页面标题
                    ->content($content);
        }
    }

    /**
     * 标记菜单
     * @return [type] [description]
     * @date   2017-08-27
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function markerMenu(){
        //是否标记菜单：0否，1是
        $model='AuthRule';
        if (IS_POST) {
            cache('admin_sidebar_menus_'.$this->currentUser['uid'],null);//清空后台菜单缓存

            $ids    = input('post.ids/a');
            $status = input('param.status');
            if (empty($ids)) {
                $this->error('请选择要操作的数据');
            }

            $map['id'] = ['in',$ids];
            switch ($status) {
                case 0 :  
                    $data = ['is_menu' => 0];
                    $this->editRow(
                        $model,
                        $data,
                        $map,
                        array('success'=>'标记成功','error'=>'标记失败')
                    );
                    break;
                case 1 :  
                    $data = ['is_menu' => 1];
                    $this->editRow(
                        $model,
                        $data,
                        $map,
                        ['success'=>'标记成功','error'=>'标记失败']
                    );
                    break;
                default :
                    $this->error('参数错误');
                    break;
            }
        }
    }

    /**
     * 移动菜单所属模块
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function moveModule() {
        if (IS_POST) {
            $ids       = input('param.ids');
            $to_module = input('param.to_module');
            if ($to_module) {
                $map['id'] = ['in',$ids];
                $data      = ['depend_flag' => $to_module];
                $this->editRow('auth_rule', $data, $map, array('success'=>'移动成功','error'=>'移动失败',U('index')));

            } else {
                $this->error('请选择目标模块');
            }
        }
    }

    /**
     * 移动菜单位置
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function moveMenusPosition() {
        if (IS_POST) {
            $ids    = input('param.ids');
            $to_pid = input('param.to_pid');
            if ($to_pid || $to_pid==0) {
                $result = logic('Auth')->moveMenusPosition($ids,$to_pid);
                if ($result) {
                    $this->success('移动成功',url('index'));
                } else{
                    $this->error('移动成功',url('index'));
                }
            } else{
                $this->error('请选择目标菜单'.$to_pid);
            }
            
        }
    }

    /**
     * 收藏菜单
     * @param  integer $id 菜单ID
     * @return [type] [description]
     * @date   2018-02-15
     * @author 心云间、凝听 <981248356@qq.com>
     */
    public function toggleCollect()
    {
        try {
            if (!IS_GET) {
                throw new \Exception("非法请求", 0);
                
            }
            $param = $this->request->param();
            $collect_menus = config('admin_collect_menus');
            if (isset($collect_menus[$param['url']])) {
                unset($collect_menus[$param['url']]);
                $return = ['code'=>2,'msg'=>'取消收藏','data'=>[]];
            } else{
                $collect_menus[$param['url']] = ['title'=>$param['title']];
                $return = ['code'=>1,'msg'=>'收藏成功','data'=>[]];
            }
            model('Config')->where('name','admin_collect_menus')->setField('value',json_encode($collect_menus));
            cache('DB_CONFIG_DATA',null);
            return json($return);
        } catch (\Exception $e) {
            return json(['code'=>0,'msg'=>$e->getMessage()]);
        }
        
    }

    /**
     * 设置角色的状态
     */
    public function setStatus($model ='auth_rule',$script = false){
        $ids = input('request.ids/a');
        if ($model =='AuthGroup') {
            if (is_array($ids)) {
                if(in_array(1, $ids)) {
                    $this->error('超级管理员不允许操作');
                }
            } else{
                if($ids === 1) {
                    $this->error('超级管理员不允许操作');
                }
            }
        } else{
            cache('admin_sidebar_menus_'.$this->currentUser['uid'],null);//清空后台菜单缓存
        }
        
        parent::setStatus($model);
    }
}