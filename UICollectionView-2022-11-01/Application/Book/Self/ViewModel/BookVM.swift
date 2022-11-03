//
//  BookVM.swift
//  UICollectionView-2022-11-01
//
//  Created by Ly Manny on 1/11/22.
//

import Foundation

class BookVM {
    
    var bookData = [BookData]()
    
    func addBook(image: UIImage, title: String, desc: String) {
        let newBook = BookData(image: image, title: title, desc: desc)
        bookData.insert(newBook, at: 0)
    }
    
    func editBook(image: UIImage, title: String, desc: String, index: Int) {
        bookData[index].image = image
        bookData[index].title = title
        bookData[index].desc  = desc
    }
    
    func getBookData() {
        
        let movie1  = UIImage(named: "movie1")
        let movie2  = UIImage(named: "movie2")
        let movie3  = UIImage(named: "movie3")
        let movie4  = UIImage(named: "movie4")
        let movie5  = UIImage(named: "movie5")
        let movie6  = UIImage(named: "movie6")
        let movie7  = UIImage(named: "movie7")
        let movie8  = UIImage(named: "movie8")
        let movie9  = UIImage(named: "movie9")
        let movie10 = UIImage(named: "movie10")
        
        bookData = [
            
            BookData(image: movie1, title: "The Disguised Princess", desc: "I'll hunt down my father's killer--or die trying. And I definitely won't fall in love with the handsome captain who saved my life, because I know he..."),
            BookData(image: movie2, title: "Fortress of Blood", desc: "Mina and her allies have found the Transylvanian countryside dotted with empty villages and whispers of monsters who wear human skin. As Mina prepares for the final showdown with her fiance's abductors, the last descendants of the supernatural Draculesti family"),
            BookData(image: movie3, title: "THE PRINCESS AND THE HORSE", desc: "Once upon a time, there was a very pretty princess who was living in a faraway castle called Yeyland. Her companion animal was a hairy horse, was the king of all horses."),
            BookData(image: movie4, title: "Anya and the Nightingale", desc: "he adventure continues in this exciting sequel to Anya and the Dragon in which a dangerous monster lurks beneath the city and only Anya can keep him from taking her friends’ magic—and their lives. Perfect for fans of The Girl Who Drank the Moon."),
            BookData(image: movie5, title: "WandaVision", desc: "WandaVision is an American television miniseries created by Jac Schaeffer for the streaming service Disney+, based on Marvel Comics featuring the characters Wanda Maximoff."),
            BookData(image: movie6, title: "Avengers: Infinity War", desc: "Avengers: Infinity War is a 2018 American superhero film based on the Marvel Comics superhero team the Avengers."),
            BookData(image: movie7, title: "Black Panther", desc: "Black Panther is a 2018 American superhero film based on the Marvel Comics character of the same name."),
            BookData(image: movie8, title: "Captain America: Civil War", desc: "Captain America: Civil War is a 2016 American superhero film based on the Marvel Comics character Captain America, produced by Marvel Studios and distributed by Walt Disney Studios Motion Pictures."),
            BookData(image: movie9, title: "ផ្កាស្រពោន", desc: "រទេះភ្លើងបោលលឿនដូចព្យុះកាត់ព្រៃខ្លុង និងព្រិចរត់ឆ្លងអូរ ហើយជ្រែកពុះជើងភ្នំ ដោយបញ្ចេញសន្ធឹកខ្ទ័ររំពងធ្វើឲ្យរញ្ជួយផែនពសុធា។ បន្តិចក្រោយមកយាននោះក៏បើកផុតជួរភ្នំ និងព្រៃស្ងាត់អស់ ហើយប្រសិនបើជាគេអើតតាមបង្អួចនៃទូណាមួយទៅ គេនឹងឃើញវាលស្រែដ៏មានភ្លឺខ្មៅប្រផេះ ខ្វែងកាត់គ្នាជាក្រឡាចត្រង្គប្រកបដោយកិរិយាចេះរត់ថយក្រោយវិញ។ \n វាលស្រែ! ពាសពេញតៗ ជាប់គ្នាដល់ជើងព្រៃដែលគេមើលទៅឃើញខៀវសន្លឹម។ នៅក្នុងវាលស្រែ សុទ្ធតែមានទឹកសស្ងាច ពេញព្រៀបដែលខ្យល់រំហើយបោកបក់បណ្តាលឲ្យកើតជារលកពព្រាំមកយោលដើមស្រូវខ្ចី ពណ៌បៃតងស្រស់។"),
            BookData(image: movie10, title: "កុលាបប៉ៃលិន", desc: "ក្នុងវេលារាត្រីនោះ ពន្លឺរស្មីនៃដួងចន្រ្ទា កំពុងចាំងឆ្លុះចូលមកតាមចន្លោះបង្អួច ហើយមានខ្យល់ត្រជាក់បក់ផាត់ផាយចូលមកយ៉ាងរំភើយៗ ល្ហើយត្រសៀកល្មមត្រជាក់ស្រួល, នៅខាងក្នុងគេហស្ថាននោះមានកូនចង្គៀងប្រេងកាត១ ចងព្យួរនឹងជញ្ជាំងក្ដារល្មមតែឆ្លុះពន្លឺ ឱ្យមើលមកឃើញបុរសជរាម្នាក់ មានរាងកាយស្គាំងស្គមឥតសាច់ឈាម មានតែស្បែកដណ្ដប់ឆ្អឹង ដេកស្ដូកស្ដឹងនាកណ្ដាលល្វែងបន្ទប់, នៅក្បែរខាងបុរសជរានេះ មានក្មេងកំឡោះម្នាក់ មុខមាត់ស្រស់បស់ អង្គុយចាំបម្រើថែរក្សាជំងឺរបស់បុរសជរា ដោយកិរិយាឫកពាស្រពោនស្រពាប់ ស្រងូតស្រង៉ាត់ ឥតមានរីករាយបន្តិចសោះ ដោយអ្នកខំអត់ងងុយទ្រាំជំងឺរបស់បុរសជរា ដែលត្រូវជាឪពុកបង្កើតរបស់ខ្លួន អស់វេលា ៣រាត្រីមកហើយ។"),
        ]
    }
    
}
