DAY 1:
1) запомнить этот код для SceneDelegate
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene) //задаем сцену для нашего окна
        
        window?.rootViewController = ViewController() //назначаем корневым VC наш класс VC
        window?.makeKeyAndVisible() //нужно, чтобы окно стало видимым
        
2)флаг translatesAutoresizingMaskIntoConstraints выключать нужно У СВОЕЙ ВЬЮХИ, а не у view класса. 

3)чтобы экран стал видимым, нужно задать view backgroundColor. 

4)высоту объекту можно задать через heightAnchor(equalToConstant:) вместо привязки к safeArea родительского view.

5)
        
