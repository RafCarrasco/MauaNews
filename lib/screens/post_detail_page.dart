// import 'package:flutter/material.dart';

// class PostDetailPage extends StatelessWidget {
//   final String imageUrl;
//   final String caption;
//   final int likes;
//   final List<Comment> comments;

//   PostDetailPage({
//     required this.imageUrl,
//     required this.caption,
//     required this.likes,
//     required this.comments,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detalhes do Post'),
//       ),
//       body: Column(
//         children: [
//           // Exiba a imagem do post aqui
//           Image.network(imageUrl),

//           // Exiba o número de curtidas e a legenda
//           Text('$likes likes'),
//           Text(caption),

//           // Exiba a lista de comentários
//           Expanded(
//             child: ListView.builder(
//               itemCount: comments.length,
//               itemBuilder: (context, index) {
//                 final comment = comments[index];
//                 return ListTile(
//                   title: Text(comment.username),
//                   subtitle: Text(comment.text),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
